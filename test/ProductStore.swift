import Foundation
import Observation

@Observable
class ProductStore {
    var products: [Product] = []
    var isLoading = false
    var errorMessage: String?

    func fetchProducts() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let url = URL(string: "https://fakestoreapi.com/products")!
            let (data, _) = try await URLSession.shared.data(from: url)
            products = try JSONDecoder().decode([Product].self, from: data)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
