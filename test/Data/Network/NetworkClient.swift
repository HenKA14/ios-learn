import Foundation

/// Generic HTTP client — equivalent to Angular's HttpClient<T>.
/// T must conform to Decodable; Swift infers the type at the call site.
final class NetworkClient {
    static let shared = NetworkClient()
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    private init() {}

    /// GET: fetches any Decodable type.
    /// Example: try await client.get([Product].self, from: url)
    func get<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(type, from: data)
    }

    /// POST: encodes any Encodable body, decodes any Decodable response.
    /// Two generic params: Response (what we get) and Body (what we send).
    func post<Response: Decodable, Body: Encodable>(
        _ type: Response.Type,
        to url: URL,
        body: Body
    ) async throws -> Response {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(body)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try decoder.decode(type, from: data)
    }
}
