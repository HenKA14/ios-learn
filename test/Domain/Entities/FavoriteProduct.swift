import SwiftData

@Model
class FavoriteProduct {
    var productId: Int
    var title: String
    var price: Double
    var image: String
    var category: String

    init(product: Product) {
        self.productId = product.id
        self.title = product.title
        self.price = product.price
        self.image = product.image
        self.category = product.category
    }
}
