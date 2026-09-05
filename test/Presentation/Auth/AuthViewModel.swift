import Foundation
import Observation

enum EstadoAuth {
    case sinAutenticar
    case cargando
    case autenticado(token: String)
    case error(mensaje: String)
}

@Observable
class AuthViewModel {
    var estado: EstadoAuth = .sinAutenticar
    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
    }

    func login(username: String, password: String) async {
        await ejecutar { try await self.repository.login(username: username, password: password) }
    }

    func loginWithApple() async {
        await ejecutar { try await self.repository.loginWithApple() }
    }

    func loginWithGoogle() async {
        await ejecutar { try await self.repository.loginWithGoogle() }
    }

    func loginWithGitHub() async {
        await ejecutar { try await self.repository.loginWithGitHub() }
    }

    func logout() {
        estado = .sinAutenticar
    }

    // Centraliza el manejo de estado para todos los métodos de login
    private func ejecutar(_ accion: () async throws -> String) async {
        estado = .cargando
        do {
            let token = try await accion()
            estado = .autenticado(token: token)
        } catch {
            estado = .error(mensaje: error.localizedDescription)
        }
    }
}
