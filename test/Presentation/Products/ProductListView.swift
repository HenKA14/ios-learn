import SwiftUI

struct ProductListView: View {
    let category: Category
    @State private var viewModel = ProductsViewModel()
    @State private var searchText = ""
    @State private var precioMax = 1000.0
    @State private var mostrarFiltros = false

    private var productosFiltrados: [Product] {
        var result = viewModel.productos
        if !searchText.isEmpty {
            result = result.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
        if precioMax < 1000 {
            result = result.filter { $0.price <= precioMax }
        }
        return result
    }

    private var filtroActivo: Bool { precioMax < 1000 }

    var body: some View {
        Group {
            switch viewModel.estado {
            case .cargando:
                ProgressView("Cargando \(category.nombre)...")
            case .error(let mensaje):
                ErrorView(mensaje: mensaje) {
                    Task { await viewModel.fetchProducts(for: category) }
                }
            case .exitoso:
                if productosFiltrados.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                } else {
                    List {
                        ForEach(productosFiltrados) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                ProductRowView(product: product)
                            }
                            .onAppear {
                                if product.id == viewModel.productos.last?.id {
                                    Task { await viewModel.loadMore(for: category) }
                                }
                            }
                        }
                        if viewModel.cargandoMas {
                            HStack { Spacer(); ProgressView(); Spacer() }
                        }
                    }
                    .listStyle(.plain)
                    .animation(.default, value: productosFiltrados.count)
                }
            }
        }
        .navigationTitle(category.nombre)
        .searchable(text: $searchText, prompt: "Buscar en \(category.nombre)")
        .toolbar {
            ToolbarItem {
                Button { mostrarFiltros = true } label: {
                    Image(systemName: filtroActivo
                        ? "line.3.horizontal.decrease.circle.fill"
                        : "line.3.horizontal.decrease.circle")
                    .foregroundStyle(filtroActivo ? .blue : .primary)
                }
            }
        }
        .sheet(isPresented: $mostrarFiltros) {
            FilterView(precioMax: $precioMax)
        }
        .task { await viewModel.fetchProducts(for: category) }
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
