import SwiftUI
import SwiftData

struct ProductDetailView: View {
    let product: Product

    @Query private var favorites: [FavoriteProduct]
    @Environment(\.modelContext) private var modelContext
    @Environment(CartViewModel.self) private var cartViewModel

    private var esFavorito: Bool {
        favorites.contains { $0.productId == product.id }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 280)

                VStack(alignment: .leading, spacing: 8) {
                    Text(product.category.capitalized)
                        .font(.caption).foregroundStyle(.secondary).textCase(.uppercase)

                    Text(product.title)
                        .font(.title2).fontWeight(.bold)

                    HStack {
                        Text(String(format: "$%.2f", product.price))
                            .font(.title3).fontWeight(.semibold).foregroundStyle(.green)
                        Spacer()
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill").foregroundStyle(.yellow)
                            Text(String(format: "%.1f", product.rating.rate))
                            Text("(\(product.rating.count))").foregroundStyle(.secondary)
                        }
                        .font(.subheadline)
                    }

                    Divider()

                    Text(product.description)
                        .font(.body).foregroundStyle(.secondary)
                }
                .padding(.horizontal)

                Button {
                    cartViewModel.agregar(product)
                } label: {
                    Label("Agregar al carrito", systemImage: "cart.badge.plus")
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle("Detalle")
        .toolbar {
            ToolbarItem {
                Button { toggleFavorito() } label: {
                    Image(systemName: esFavorito ? "heart.fill" : "heart")
                        .foregroundStyle(.red)
                }
            }
        }
    }

    private func toggleFavorito() {
        if esFavorito {
            if let fav = favorites.first(where: { $0.productId == product.id }) {
                modelContext.delete(fav)
            }
        } else {
            modelContext.insert(FavoriteProduct(product: product))
        }
    }
}
