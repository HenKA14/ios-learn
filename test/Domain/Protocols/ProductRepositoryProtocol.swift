import Foundation

/// Defines the contract for product data access.
/// Implementations can fetch from any API source defined in `Category.Fuente`.
protocol ProductRepositoryProtocol {
    /// Fetches the product list for a given category.
    /// Routes to FakeStore or DummyJSON based on the category's `fuente`.
    func getProducts(for category: Category) async throws -> [Product]
}
