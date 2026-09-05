import SwiftUI

struct LoginView: View {
    let authViewModel: AuthViewModel

    @State private var username = ""
    @State private var password = ""
    @FocusState private var campoActivo: Campo?

    enum Campo { case usuario, contrasena }

    private var cargando: Bool {
        if case .cargando = authViewModel.estado { return true }
        return false
    }

    private var mensajeError: String? {
        if case .error(let msg) = authViewModel.estado { return msg }
        return nil
    }

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 28) {
                // Cabecera
                VStack(spacing: 10) {
                    Image(systemName: "bag.fill")
                        .font(.system(size: 52))
                        .foregroundStyle(.blue)
                    Text("FakeStore")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Inicia sesión para continuar")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                // Formulario usuario/contraseña
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Usuario")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        TextField("admin", text: $username)
                            .textFieldStyle(.roundedBorder)
                            .focused($campoActivo, equals: .usuario)
                            .onSubmit { campoActivo = .contrasena }
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Contraseña")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        SecureField("••••••", text: $password)
                            .textFieldStyle(.roundedBorder)
                            .focused($campoActivo, equals: .contrasena)
                            .onSubmit { Task { await authViewModel.login(username: username, password: password) } }
                    }

                    if let error = mensajeError {
                        HStack(spacing: 6) {
                            Image(systemName: "exclamationmark.circle.fill")
                            Text(error)
                        }
                        .font(.caption)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    Button {
                        Task { await authViewModel.login(username: username, password: password) }
                    } label: {
                        Group {
                            if cargando {
                                ProgressView().controlSize(.small)
                            } else {
                                Text("Iniciar sesión")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 28)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(username.isEmpty || password.isEmpty || cargando)
                }

                // Divisor
                HStack {
                    Rectangle().frame(height: 1).foregroundStyle(.quaternary)
                    Text("o continúa con").font(.caption).foregroundStyle(.secondary)
                    Rectangle().frame(height: 1).foregroundStyle(.quaternary)
                }

                // Login social
                HStack(spacing: 12) {
                    SocialLoginButton(icon: "apple.logo", label: "Apple") {
                        Task { await authViewModel.loginWithApple() }
                    }
                    SocialLoginButton(icon: "g.circle.fill", label: "Google") {
                        Task { await authViewModel.loginWithGoogle() }
                    }
                    SocialLoginButton(icon: "person.crop.circle", label: "GitHub") {
                        Task { await authViewModel.loginWithGitHub() }
                    }
                }
                .disabled(cargando)

                // Hint
                VStack(spacing: 3) {
                    Text("Credenciales de prueba")
                        .font(.caption2).foregroundStyle(.tertiary)
                    Text("usuario: admin  ·  contraseña: admin")
                        .font(.caption2).foregroundStyle(.tertiary).monospaced()
                }
            }
            .frame(width: 300)
            .padding(28)
            .background(.background.shadow(.drop(radius: 8, y: 4)))
            .clipShape(RoundedRectangle(cornerRadius: 14))

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .onAppear { campoActivo = .usuario }
    }
}

private struct SocialLoginButton: View {
    let icon: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                Text(label).font(.caption).fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 7)
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    LoginView(authViewModel: AuthViewModel())
}
