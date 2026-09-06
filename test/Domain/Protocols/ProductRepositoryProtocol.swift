import Foundation

/// Defines the contract for product data access.
/// Implementations can fetch from any API source defined in `Category.Fuente`.
protocol ProductRepositoryProtocol {
    /// Fetches a paginated product list for a given category.
    /// - Parameters:
    ///   - skip: number of products to offset (for pagination)
    ///   - limit: maximum number of products to return
    func getProducts(for category: Category, skip: Int, limit: Int) async throws -> [Product]
}
