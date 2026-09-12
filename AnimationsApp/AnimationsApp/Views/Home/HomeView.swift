import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var cart: CartStore
    @EnvironmentObject private var auth: AuthStore
    @State private var selectedCategory = "Todo"
    @State private var searchText = ""
    @State private var showCart = false
    @State private var showProfile = false

    private var firstName: String {
        auth.currentEmail.components(separatedBy: "@").first?.capitalized ?? "there"
    }

    private var filteredProducts: [Product] {
        let byCategory = selectedCategory == "Todo"
            ? Product.sampleData
            : Product.sampleData.filter { $0.category == selectedCategory }
        guard !searchText.isEmpty else { return byCategory }
        return byCategory.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color.freshBackground.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        headerSection
                        heroSection
                        categorySection
                        productsSection
                    }
                }
                .scrollIndicators(.hidden)

                if cart.itemCount > 0 {
                    cartFloatingButton
                        .padding(.horizontal, 22)
                        .padding(.bottom, 34)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: cart.itemCount > 0)
            .sheet(isPresented: $showCart)    { CartView() }
            .sheet(isPresented: $showProfile) { ProfileView() }
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text("Hola, \(firstName) 👋")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.secondary)
                    Text("¿Qué compramos hoy?")
                        .font(.system(size: 23, weight: .black))
                        .tracking(-0.5)
                }
                Spacer()
                HStack(spacing: 10) {
                    cartIconButton
                    profileIconButton
                }
            }
            searchBar
        }
        .padding(.horizontal, 22)
        .padding(.top, 20)
        .padding(.bottom, 6)
    }

    private var cartIconButton: some View {
        Button { showCart = true } label: {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart.fill")
                    .font(.system(size: 19))
                    .frame(width: 46, height: 46)
                    .foregroundStyle(.white)
                    .background(Color.freshGreen, in: Circle())
                    .shadow(color: Color.freshGreen.opacity(0.35), radius: 8, x: 0, y: 3)

                if cart.itemCount > 0 {
                    Text("\(cart.itemCount)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 18, height: 18)
                        .background(.red, in: Circle())
                        .offset(x: 4, y: -4)
                        .transition(.scale)
                }
            }
            .animation(.spring(response: 0.3), value: cart.itemCount)
        }
        .buttonStyle(.plain)
    }

    private var profileIconButton: some View {
        Button { showProfile = true } label: {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 40))
                .foregroundStyle(Color.freshGreen.opacity(0.75))
        }
        .buttonStyle(.plain)
    }

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass").foregroundStyle(.secondary).font(.system(size: 16))
            TextField("Buscar frutas, verduras...", text: $searchText).font(.system(size: 15))
            if !searchText.isEmpty {
                Button { searchText = "" } label: {
                    Image(systemName: "xmark.circle.fill").foregroundStyle(.secondary)
                }
            }
        }
        .padding(.horizontal, 16).padding(.vertical, 13)
        .background(.white, in: RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }

    // MARK: - Hero

    private var heroSection: some View {
        FloatingHeroView()
            .padding(.horizontal, 22)
            .padding(.top, 32)    // extra space so overflowing items don't clip
            .padding(.bottom, 18)
    }

    // MARK: - Categories

    private var categorySection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(GroceryCategory.all) { cat in
                    categoryPill(cat)
                }
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 6)
        }
    }

    private func categoryPill(_ category: GroceryCategory) -> some View {
        let selected = selectedCategory == category.name
        return Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                selectedCategory = category.name
            }
        } label: {
            HStack(spacing: 6) {
                Text(category.emoji).font(.system(size: 15))
                Text(category.name).font(.system(size: 14, weight: .semibold))
            }
            .padding(.horizontal, 18).padding(.vertical, 10)
            .foregroundStyle(selected ? .white : Color(.darkGray))
            .background(selected ? Color.freshGreen : Color.white, in: Capsule())
            .shadow(color: selected ? Color.freshGreen.opacity(0.3) : .black.opacity(0.06), radius: 6, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Products

    private var productsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Productos frescos").font(.system(size: 18, weight: .bold))
                Spacer()
                Text("\(filteredProducts.count) items").font(.system(size: 13)).foregroundStyle(.secondary)
            }
            .padding(.horizontal, 22)
            .padding(.top, 6)

            if filteredProducts.isEmpty {
                emptySearchView
            } else {
                LazyVGrid(
                    columns: [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)],
                    spacing: 14
                ) {
                    ForEach(filteredProducts) { ProductCard(product: $0) }
                }
                .padding(.horizontal, 22)
            }
        }
        .padding(.bottom, cart.itemCount > 0 ? 110 : 40)
    }

    private var emptySearchView: some View {
        VStack(spacing: 10) {
            Text("🔍").font(.system(size: 40))
            Text("Sin resultados para \"\(searchText)\"")
                .font(.system(size: 15)).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity).padding(.vertical, 40)
    }

    // MARK: - Floating cart CTA

    private var cartFloatingButton: some View {
        Button { showCart = true } label: {
            HStack(spacing: 0) {
                Text("Ver carrito · \(cart.itemCount) items")
                    .font(.system(size: 15, weight: .semibold))
                Spacer()
                Text(String(format: "$%.2f", cart.total))
                    .font(.system(size: 15, weight: .bold))
                Image(systemName: "arrow.right")
                    .font(.system(size: 13, weight: .bold))
                    .padding(.leading, 6)
            }
            .padding(.horizontal, 22).padding(.vertical, 16)
            .foregroundStyle(.white)
            .background(Color.freshGreen, in: RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.freshGreen.opacity(0.45), radius: 16, x: 0, y: 8)
        }
        .buttonStyle(.plain)
    }
}
