import Foundation

struct DummyJSONResponse: Decodable {
    let products: [DummyJSONProductDTO]
}

struct DummyJSONProductDTO: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let thumbnail: String
    let rating: Double

    func toDomain() -> Product {
        Product(
            id: id,
            title: title,
            price: price,
            description: description,
            category: category,
            image: thumbnail,
            rating: Product.Rating(rate: rating, count: 0)
        )
    }
}
