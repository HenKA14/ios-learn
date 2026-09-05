import Foundation
import Observation

// Un solo tipo que representa los 3 estados posibles — nunca pueden coexistir
enum EstadoCarga {
    case cargando
    case error(mensaje: String)
    case exitoso(productos: [Product])
}

@Observable
class ProductStore {
    var estado: EstadoCarga = .cargando

    func fetchProducts() async {
        estado = .cargando

        do {
            let url = URL(string: "https://fakestoreapi.com/products")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let productos = try JSONDecoder().decode([Product].self, from: data)
            estado = .exitoso(productos: productos)
        } catch {
            estado = .error(mensaje: error.localizedDescription)
        }
    }
}
