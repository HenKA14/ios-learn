import Foundation
import Observation

enum EstadoAuth {
    case sinAutenticar
    case cargando
    case autenticado(token: String)
    case error(mensaje: String)
}

enum ValidacionError: LocalizedError {
    case campoVacio(campo: String)
    case contrasenaCorta

    var errorDescription: String? {
        switch self {
        case .campoVacio(let campo): return "\(campo) no puede estar vacío"
        case .contrasenaCorta: return "La contraseña debe tener al menos 4 caracteres"
        }
    }
}

@Observable
class AuthViewModel {
    var estado: EstadoAuth = .sinAutenticar
    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
    }

    /// Synchronous form validation using Result<Void, Error> —
    /// ideal for cases where async is not needed, like checking empty fields.
    /// Equivalent to a sync validator in Angular's Validators class.
    func validar(username: String, password: String) -> Result<Void, ValidacionError> {
        guard !username.isEmpty else { return .failure(.campoVacio(campo: "El usuario")) }
        guard !password.isEmpty else { return .failure(.campoVacio(campo: "La contraseña")) }
        guard password.count >= 4 else { return .failure(.contrasenaCorta) }
        return .success(())
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
