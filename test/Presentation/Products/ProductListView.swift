import SwiftUI

struct ProductListView: View {
    let category: Category
    @State private var viewModel = ProductsViewModel()

    var body: some View {
        Group {
            switch viewModel.estado {
            case .cargando:
                ProgressView("Cargando \(category.nombre)...")
            case .error(let mensaje):
                ErrorView(mensaje: mensaje) {
                    Task { await viewModel.fetchProducts(for: category) }
                }
            case .exitoso(let productos):
                List(productos) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        ProductRowView(product: product)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(category.nombre)
        .task {
            await viewModel.fetchProducts(for: category)
        }
    }
}

private struct ErrorView: View {
    let mensaje: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle).foregroundStyle(.red)
            Text(mensaje).multilineTextAlignment(.center)
            Button("Reintentar", action: onRetry).buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        ProductListView(category: Category.all[0])
    }
}
