import Foundation

class ProductRepository: ProductRepositoryProtocol {

    func getProducts(for category: Category) async throws -> [Product] {
        switch category.fuente {
        case .fakeStore(let categoria):
            return try await fetchFakeStore(categoria: categoria)
        case .dummyJSON(let categoria):
            return try await fetchDummyJSON(categoria: categoria)
        }
    }

    private func fetchFakeStore(categoria: String) async throws -> [Product] {
        let encoded = categoria.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? categoria
        let url = URL(string: "https://fakestoreapi.com/products/category/\(encoded)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Product].self, from: data)
    }

    private func fetchDummyJSON(categoria: String) async throws -> [Product] {
        let url = URL(string: "https://dummyjson.com/products/category/\(categoria)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(DummyJSONResponse.self, from: data)
        return response.products.map { $0.toDomain() }
    }
}
