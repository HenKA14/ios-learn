import Foundation

protocol AuthRepositoryProtocol {
    func login(username: String, password: String) async throws -> String
    func loginWithApple() async throws -> String
    func loginWithGoogle() async throws -> String
    func loginWithGitHub() async throws -> String
}
