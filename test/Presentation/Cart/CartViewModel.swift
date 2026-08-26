import Foundation
import Observation

@Observable
class CartViewModel {

    struct CartItem: Identifiable {
        let id = UUID()
        let product: Product
        var cantidad: Int
    }

    var items: [CartItem] = []

    var totalItems: Int {
        items.reduce(0) { $0 + $1.cantidad }
    }

    var totalPrecio: Double {
        items.reduce(0) { $0 + $1.product.price * Double($1.cantidad) }
    }

    func agregar(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].cantidad += 1
        } else {
            items.append(CartItem(product: product, cantidad: 1))
        }
    }

    func decrementar(_ item: CartItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        if items[index].cantidad > 1 {
            items[index].cantidad -= 1
        } else {
            items.remove(at: index)
        }
    }

    func vaciar() {
        items.removeAll()
    }
}
