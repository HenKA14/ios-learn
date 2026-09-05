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

    func login(username: String, password: String) async throws -> String {
        // Simula delay de red
        try await Task.sleep(for: .seconds(1))

        guard username == "admin" && password == "admin" else {
            throw AuthError.credencialesInvalidas
        }
        return "mock-jwt-token-admin"
    }

    func loginWithApple() async throws -> String {
        try await Task.sleep(for: .seconds(1))
        // TODO: integrar AuthenticationServices (requiere entitlement de Apple)
        return "mock-jwt-token-apple"
    }

    func loginWithGoogle() async throws -> String {
        try await Task.sleep(for: .seconds(1))
        // TODO: integrar GoogleSignIn SDK via SPM
        return "mock-jwt-token-google"
    }

    func loginWithGitHub() async throws -> String {
        try await Task.sleep(for: .seconds(1))
        // TODO: implementar OAuth2 web flow con GitHub
        return "mock-jwt-token-github"
    }
}
