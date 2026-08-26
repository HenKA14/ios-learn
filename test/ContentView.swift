import SwiftUI

struct ContentView: View {
    @State private var store = ProductStore()

    var body: some View {
        NavigationStack {
            Group {
                if store.isLoading {
                    ProgressView("Cargando productos...")
                } else if let error = store.errorMessage {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(.red)
                        Text(error)
                            .multilineTextAlignment(.center)
                        Button("Reintentar") {
                            Task { await store.fetchProducts() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    List(store.products) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductRowView(product: product)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Productos")
        }
        .task {
            await store.fetchProducts()
        }
    }
}

struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.subheadline)
                    .lineLimit(2)
                Text(product.category.capitalized)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(String(format: "$%.2f", product.price))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.green)
            }
        }
        .padding(.vertical, 4)
    }
}

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: product.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 280)

                VStack(alignment: .leading, spacing: 8) {
                    Text(product.category.capitalized)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)

                    Text(product.title)
                        .font(.title2)
                        .fontWeight(.bold)

                    HStack {
                        Text(String(format: "$%.2f", product.price))
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.green)
                        Spacer()
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            Text(String(format: "%.1f", product.rating.rate))
                            Text("(\(product.rating.count))")
                                .foregroundStyle(.secondary)
                        }
                        .font(.subheadline)
                    }

                    Divider()

                    Text(product.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle("Detalle")
    }
}

#Preview {
    ContentView()
}
