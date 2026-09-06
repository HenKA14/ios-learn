import SwiftData

@Model
class FavoriteProduct {
    var productId: Int
    var title: String
    var price: Double
    var image: String
    var category: String
    var productDescription: String = ""
    var ratingRate: Double = 0.0
    var ratingCount: Int = 0

    init(product: Product) {
        self.productId = product.id
        self.title = product.title
        self.price = product.price
        self.image = product.image
        self.category = product.category
        self.productDescription = product.description
        self.ratingRate = product.rating.rate
        self.ratingCount = product.rating.count
    }

    func toProduct() -> Product {
        Product(
            id: productId,
            title: title,
            price: price,
            description: productDescription,
            category: category,
            image: image,
            rating: Product.Rating(rate: ratingRate, count: ratingCount)
        )
    }
}
