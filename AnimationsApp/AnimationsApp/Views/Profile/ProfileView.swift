import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var auth: AuthStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                avatarSection
                    .padding(.vertical, 36)

                Divider().padding(.horizontal, 32)

                infoSection
                    .padding(.top, 28)

                Spacer()

                logoutButton
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Mi perfil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cerrar") { dismiss() }.fontWeight(.medium)
                }
            }
        }
        .background(Color.freshBackground)
    }

    private var avatarSection: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(Color.freshCard)
                .frame(width: 86, height: 86)
                .overlay(
                    Text("👤").font(.system(size: 44))
                )
                .shadow(color: Color.freshGreen.opacity(0.2), radius: 12, x: 0, y: 4)

            Text(auth.currentEmail)
                .font(.system(size: 16, weight: .semibold))
            Text("Cuenta demo").font(.system(size: 13)).foregroundStyle(.secondary)
        }
    }

    private var infoSection: some View {
        VStack(spacing: 0) {
            infoRow(icon: "shippingbox", label: "Mis pedidos", value: "Ver historial")
            Divider().padding(.leading, 52)
            infoRow(icon: "mappin.circle", label: "Dirección", value: "Buenos Aires")
            Divider().padding(.leading, 52)
            infoRow(icon: "creditcard", label: "Pago", value: "Efectivo")
        }
        .padding(.horizontal, 24)
    }

    private func infoRow(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .frame(width: 24)
                .foregroundStyle(Color.freshGreen)
            Text(label).font(.system(size: 15))
            Spacer()
            Text(value).font(.system(size: 14)).foregroundStyle(.secondary)
            Image(systemName: "chevron.right")
                .font(.system(size: 12))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 14)
    }

    private var logoutButton: some View {
        Button {
            dismiss()
            auth.logout()
        } label: {
            Label("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(red: 1.0, green: 0.94, blue: 0.94), in: RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
}
