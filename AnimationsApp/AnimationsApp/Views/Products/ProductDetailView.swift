import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject private var cart: CartStore
    @Environment(\.dismiss) private var dismiss
    @State private var quantity = 1

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                heroSection
                detailSection
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            addToCartBar
        }
    }

    // MARK: - Hero emoji

    private var heroSection: some View {
        ZStack {
            Color.freshCard.ignoresSafeArea(edges: .top)
            Text(product.emoji)
                .font(.system(size: 110))
                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
                .padding(.vertical, 40)
        }
        .frame(height: 240)
    }

    // MARK: - Detail content

    private var detailSection: some View {
        VStack(alignment: .leading, spacing: 22) {
            nameAndRating
            badgeRow
            Divider()
            descriptionBlock
            Divider()
            priceAndQuantity
        }
        .padding(24)
    }

    private var nameAndRating: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(product.name).font(.system(size: 26, weight: .bold))
            HStack(spacing: 4) {
                ForEach(0..<5) { i in
                    Image(systemName: i < Int(product.rating.rounded()) ? "star.fill" : "star")
                        .font(.system(size: 13))
                        .foregroundStyle(.yellow)
                }
                Text(String(format: "%.1f", product.rating))
                    .font(.system(size: 13, weight: .semibold))
                    .padding(.leading, 2)
                Text("(\(product.reviewCount) reseñas)")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var badgeRow: some View {
        HStack(spacing: 10) {
            infoBadge(text: product.weight,   icon: "scalemass")
            infoBadge(text: product.category, icon: "leaf")
            infoBadge(text: "Fresco hoy",     icon: "checkmark.seal.fill", color: .freshGreen)
        }
    }

    private func infoBadge(text: String, icon: String, color: Color = .secondary) -> some View {
        HStack(spacing: 5) {
            Image(systemName: icon).font(.system(size: 11)).foregroundStyle(color)
            Text(text).font(.system(size: 12, weight: .medium))
        }
        .padding(.horizontal, 12).padding(.vertical, 7)
        .background(Color.freshCard, in: Capsule())
    }

    private var descriptionBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Descripción").font(.system(size: 16, weight: .semibold))
            Text(product.description)
                .font(.system(size: 15))
                .foregroundStyle(.secondary)
                .lineSpacing(5)
        }
    }

    private var priceAndQuantity: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Precio unitario").font(.system(size: 12)).foregroundStyle(.secondary)
                Text(String(format: "$%.2f", product.price))
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color.freshGreen)
            }
            Spacer()
            quantityStepper
        }
    }

    private var quantityStepper: some View {
        HStack(spacing: 16) {
            stepButton(symbol: "minus", filled: false) {
                if quantity > 1 { quantity -= 1 }
            }
            Text("\(quantity)").font(.system(size: 18, weight: .bold)).frame(minWidth: 24)
            stepButton(symbol: "plus", filled: true) { quantity += 1 }
        }
    }

    private func stepButton(symbol: String, filled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: 13, weight: .bold))
                .frame(width: 38, height: 38)
                .foregroundStyle(filled ? .white : Color.freshGreen)
                .background(filled ? Color.freshGreen : Color.freshCard, in: Circle())
        }
        .buttonStyle(.plain)
    }

    // MARK: - Add to cart bar

    private var addToCartBar: some View {
        VStack(spacing: 0) {
            Button {
                for _ in 0..<quantity { cart.add(product) }
                dismiss()
            } label: {
                HStack {
                    Text("Agregar al carrito").font(.system(size: 16, weight: .bold))
                    Spacer()
                    Text(String(format: "$%.2f", product.price * Double(quantity)))
                        .font(.system(size: 16, weight: .bold))
                }
                .padding(.horizontal, 24).padding(.vertical, 18)
                .foregroundStyle(.white)
                .background(Color.freshGreen, in: RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color.freshGreen.opacity(0.4), radius: 12, x: 0, y: 6)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 22)
            .padding(.top, 10)
            .padding(.bottom, 28)
        }
        .background(.white)
    }
}
