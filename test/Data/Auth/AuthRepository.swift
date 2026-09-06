import Foundation

enum AuthError: LocalizedError {
    case credencialesInvalidas
    case servicioNoDisponible

    var errorDescription: String? {
        switch self {
        case .credencialesInvalidas: return "Usuario o contraseña incorrectos"
        case .servicioNoDisponible: return "Servicio no disponible. Intenta más tarde"
        }
    }
}

class AuthRepository: AuthRepositoryProtocol {
    private let client = NetworkClient.shared

    func login(username: String, password: String) async throws -> String {
        try await Task.sleep(for: .seconds(1))
        guard username == "admin" && password == "admin" else {
            throw AuthError.credencialesInvalidas
        }
        return "mock-jwt-token-admin"
    }

    func loginWithApple() async throws -> String {
        try await Task.sleep(for: .seconds(1))
        return "mock-jwt-token-apple"
    }

    func loginWithGoogle() async throws -> String {
        try await Task.sleep(for: .seconds(1))
        return "mock-jwt-token-google"
    }

    func loginWithGitHub() async throws -> String {
        try await Task.sleep(for: .seconds(1))
        return "mock-jwt-token-github"
    }
}
