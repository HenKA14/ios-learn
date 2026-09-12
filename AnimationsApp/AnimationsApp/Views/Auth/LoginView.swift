import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var auth: AuthStore
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var isLoading = false

    var body: some View {
        ZStack {
            Color.freshBackground.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                brandHeader
                Spacer().frame(height: 44)
                formSection
                Spacer()
                demoNote
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showError)
    }

    // MARK: - Brand

    private var brandHeader: some View {
        VStack(spacing: 14) {
            Text("🛒").font(.system(size: 68))
            Text("FreshMarket")
                .font(.system(size: 34, weight: .black))
                .tracking(-1)
            Text("Tu mercado fresco favorito")
                .font(.system(size: 15))
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Form

    private var formSection: some View {
        VStack(spacing: 12) {
            formField(icon: "envelope") {
                TextField("Correo electrónico", text: $email)
                    .emailFieldStyle()
            }

            formField(icon: "lock") {
                SecureField("Contraseña", text: $password)
                    .autocorrectionDisabled()
            }

            if showError {
                Text("Ingresá tu correo y contraseña.")
                    .font(.system(size: 13))
                    .foregroundStyle(.red)
                    .transition(.opacity)
            }

            loginButton.padding(.top, 6)

            Button("Continuar sin cuenta") {
                auth.login(email: "invitado@freshmarket.com", password: "")
            }
            .font(.system(size: 14))
            .foregroundStyle(.secondary)
            .padding(.top, 2)
        }
        .padding(.horizontal, 28)
    }

    private func formField<Content: View>(icon: String, @ViewBuilder content: () -> Content) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.secondary)
                .frame(width: 20)
            content().font(.system(size: 16))
        }
        .padding(16)
        .background(.white, in: RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
    }

    private var loginButton: some View {
        Button(action: attemptLogin) {
            ZStack {
                if isLoading {
                    ProgressView().tint(.white)
                } else {
                    Text("Ingresar").font(.system(size: 16, weight: .bold))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .foregroundStyle(.white)
            .background(Color.freshGreen, in: RoundedRectangle(cornerRadius: 18))
            .shadow(color: Color.freshGreen.opacity(0.4), radius: 12, x: 0, y: 6)
        }
        .buttonStyle(.plain)
        .disabled(isLoading)
    }

    private var demoNote: some View {
        Text("Demo — no se almacenan datos reales.")
            .font(.system(size: 11))
            .foregroundStyle(Color.secondary.opacity(0.6))
            .padding(.bottom, 20)
    }

    // MARK: - Actions

    private func attemptLogin() {
        guard !email.isEmpty, !password.isEmpty else {
            withAnimation { showError = true }
            return
        }
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            isLoading = false
            auth.login(email: email, password: password)
        }
    }
}
