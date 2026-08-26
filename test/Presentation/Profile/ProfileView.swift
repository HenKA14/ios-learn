import SwiftUI

struct ProfileView: View {
    let authViewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(.blue)

                Text("admin")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("admin@fakestore.com")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()

                Button("Cerrar sesión", role: .destructive) {
                    authViewModel.logout()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .padding(.bottom, 32)
            }
            .navigationTitle("Perfil")
        }
    }
}
