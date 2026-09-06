import Foundation

/// Defines the contract for authentication operations.
/// The Data layer provides the concrete implementation.
protocol AuthRepositoryProtocol {
    /// Authenticates with username and password. Returns a JWT token on success.
    func login(username: String, password: String) async throws -> String

    /// Authenticates via Sign in with Apple. Returns a JWT token on success.
    func loginWithApple() async throws -> String

    /// Authenticates via Google Sign-In. Returns a JWT token on success.
    func loginWithGoogle() async throws -> String

    /// Authenticates via GitHub OAuth. Returns a JWT token on success.
    func loginWithGitHub() async throws -> String
}
