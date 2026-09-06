import Foundation

class ProductRepository: ProductRepositoryProtocol {
    private let client = NetworkClient.shared

    func getProducts(for category: Category, skip: Int, limit: Int) async throws -> [Product] {
        switch category.fuente {
        case .fakeStore(let categoria):
            return try await fetchFakeStore(categoria: categoria, limit: limit)
        case .dummyJSON(let categoria):
            return try await fetchDummyJSON(categoria: categoria, skip: skip, limit: limit)
        }
    }

    private func fetchFakeStore(categoria: String, limit: Int) async throws -> [Product] {
        let encoded = categoria.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? categoria
        let url = URL(string: "https://fakestoreapi.com/products/category/\(encoded)?limit=\(limit)")!
        return try await client.get([Product].self, from: url)
    }

    private func fetchDummyJSON(categoria: String, skip: Int, limit: Int) async throws -> [Product] {
        let url = URL(string: "https://dummyjson.com/products/category/\(categoria)?limit=\(limit)&skip=\(skip)")!
        let response = try await client.get(DummyJSONResponse.self, from: url)
        return response.products.map { $0.toDomain() }
    }
}
