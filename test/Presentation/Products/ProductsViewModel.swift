import Foundation
import Observation

enum EstadoCarga {
    case cargando
    case error(mensaje: String)
    case exitoso(productos: [Product])
}

@Observable
class ProductsViewModel {
    var estado: EstadoCarga = .cargando
    private let repository: ProductRepositoryProtocol

    init(repository: ProductRepositoryProtocol = ProductRepository()) {
        self.repository = repository
    }

    func fetchProducts(for category: Category) async {
        estado = .cargando
        do {
            let productos = try await repository.getProducts(for: category)
            estado = .exitoso(productos: productos)
        } catch {
            estado = .error(mensaje: error.localizedDescription)
        }
    }
}
