import Foundation
import Observation

enum EstadoCarga {
    case cargando
    case error(mensaje: String)
    case exitoso
}

@Observable
class ProductsViewModel {
    var estado: EstadoCarga = .cargando
    private(set) var productos: [Product] = []
    var cargandoMas = false
    var hayMas = true

    private var skip = 0
    private let limite = 10
    private let repository: ProductRepositoryProtocol

    init(repository: ProductRepositoryProtocol = ProductRepository()) {
        self.repository = repository
    }

    func fetchProducts(for category: Category) async {
        skip = 0
        productos = []
        hayMas = true
        estado = .cargando
        do {
            let nuevos = try await repository.getProducts(for: category, skip: 0, limit: limite)
            productos = nuevos
            skip = nuevos.count
            hayMas = nuevos.count == limite
            estado = .exitoso
        } catch {
            estado = .error(mensaje: error.localizedDescription)
        }
    }

    func loadMore(for category: Category) async {
        guard hayMas && !cargandoMas else { return }
        cargandoMas = true
        defer { cargandoMas = false }
        do {
            let nuevos = try await repository.getProducts(for: category, skip: skip, limit: limite)
            productos.append(contentsOf: nuevos)
            skip += nuevos.count
            hayMas = nuevos.count == limite
        } catch {}
    }
}
