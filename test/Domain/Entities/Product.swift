import Foundation

/// Core domain entity representing a product.
/// Decodable maps directly to the FakeStore API schema.
/// DummyJSON products are mapped via `DummyJSONProductDTO.toDomain()`.
struct Product: Identifiable, Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating

    struct Rating: Decodable {
        let rate: Double
        /// Review count. Set to 0 when mapped from DummyJSON (not provided).
        let count: Int
    }
}
