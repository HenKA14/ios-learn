import Foundation

protocol ProductRepositoryProtocol {
    func getProducts(for category: Category) async throws -> [Product]
}
