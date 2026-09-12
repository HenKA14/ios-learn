import Foundation
import Combine

class CartStore: ObservableObject {
    @Published var items: [CartItem] = []

    struct CartItem: Identifiable {
        let id: UUID
        let product: Product
        var quantity: Int

        init(product: Product, quantity: Int = 1) {
            self.id = UUID()
            self.product = product
            self.quantity = quantity
        }
    }

    var total: Double {
        items.reduce(0) { $0 + $1.product.price * Double($1.quantity) }
    }

    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    func add(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(product: product))
        }
    }

    func remove(_ product: Product) {
        guard let index = items.firstIndex(where: { $0.product.id == product.id }) else { return }
        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
    }

    func quantity(for product: Product) -> Int {
        items.first(where: { $0.product.id == product.id })?.quantity ?? 0
    }

    func clear() {
        items = []
    }
}
