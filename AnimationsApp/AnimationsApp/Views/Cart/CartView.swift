import SwiftUI

struct CartView: View {
    @EnvironmentObject private var cart: CartStore
    @Environment(\.dismiss) private var dismiss
    @State private var orderPlaced = false

    var body: some View {
        NavigationStack {
            Group {
                if orderPlaced {
                    orderSuccessView
                } else if cart.items.isEmpty {
                    emptyView
                } else {
                    cartContent
                }
            }
            .navigationTitle("Mi carrito")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cerrar") { dismiss() }.fontWeight(.medium)
                }
            }
        }
        .background(Color.freshBackground)
    }

    // MARK: - Empty state

    private var emptyView: some View {
        VStack(spacing: 16) {
            Text("🛒").font(.system(size: 64))
            Text("Tu carrito está vacío")
                .font(.system(size: 20, weight: .semibold))
            Text("Agrega algunos productos\npara comenzar")
                .font(.system(size: 14)).foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Button("Ver productos") { dismiss() }
                .font(.system(size: 15, weight: .semibold)).foregroundStyle(.white)
                .padding(.horizontal, 30).padding(.vertical, 14)
                .background(Color.freshGreen, in: Capsule())
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Cart list

    private var cartContent: some View {
        VStack(spacing: 0) {
            List {
                ForEach(cart.items) { item in
                    cartRow(item)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)

            checkoutPanel
        }
    }

    private func cartRow(_ item: CartStore.CartItem) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.freshCard).frame(width: 62, height: 62)
                Text(item.product.emoji)
                    .font(.system(size: 34))
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(item.product.name).font(.system(size: 15, weight: .semibold))
                Text(item.product.weight).font(.system(size: 12)).foregroundStyle(.secondary)
                Text(String(format: "$%.2f", item.product.price * Double(item.quantity)))
                    .font(.system(size: 14, weight: .bold)).foregroundStyle(Color.freshGreen)
            }

            Spacer()

            HStack(spacing: 8) {
                stepperBtn(symbol: "minus", filled: false) {
                    withAnimation(.spring(response: 0.25)) { cart.remove(item.product) }
                }
                Text("\(item.quantity)").font(.system(size: 15, weight: .bold)).frame(minWidth: 20)
                stepperBtn(symbol: "plus", filled: true) {
                    withAnimation(.spring(response: 0.25)) { cart.add(item.product) }
                }
            }
        }
        .padding(14)
        .background(.white, in: RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
    }

    private func stepperBtn(symbol: String, filled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: 11, weight: .bold))
                .frame(width: 28, height: 28)
                .foregroundStyle(filled ? .white : Color.freshGreen)
                .background(filled ? Color.freshGreen : Color.freshCard, in: Circle())
        }
        .buttonStyle(.plain)
    }

    // MARK: - Checkout panel

    private var checkoutPanel: some View {
        VStack(spacing: 16) {
            Divider()
            VStack(spacing: 10) {
                summaryRow("Subtotal", value: String(format: "$%.2f", cart.total))
                summaryRow("Envío", value: "Gratis", valueColor: .freshGreen)
                Divider()
                HStack {
                    Text("Total").font(.system(size: 17, weight: .bold))
                    Spacer()
                    Text(String(format: "$%.2f", cart.total))
                        .font(.system(size: 20, weight: .bold)).foregroundStyle(Color.freshGreen)
                }
            }
            .padding(.horizontal, 22)

            Button {
                withAnimation(.spring(response: 0.4)) { orderPlaced = true }
            } label: {
                Text("Confirmar pedido")
                    .font(.system(size: 16, weight: .bold)).frame(maxWidth: .infinity)
                    .padding(.vertical, 18).foregroundStyle(.white)
                    .background(Color.freshGreen, in: RoundedRectangle(cornerRadius: 18))
                    .shadow(color: Color.freshGreen.opacity(0.4), radius: 12, x: 0, y: 6)
            }
            .buttonStyle(.plain).padding(.horizontal, 22).padding(.bottom, 24)
        }
        .background(.white)
    }

    private func summaryRow(_ label: String, value: String, valueColor: Color = .primary) -> some View {
        HStack {
            Text(label).foregroundStyle(.secondary)
            Spacer()
            Text(value).foregroundStyle(valueColor).fontWeight(.semibold)
        }
        .font(.system(size: 15))
    }

    // MARK: - Success state

    private var orderSuccessView: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("🎉").font(.system(size: 72))
            Text("¡Pedido confirmado!").font(.system(size: 26, weight: .bold))
            Text("Tu pedido está en camino.\nLlegará en 30–45 minutos.")
                .font(.system(size: 15)).foregroundStyle(.secondary)
                .multilineTextAlignment(.center).lineSpacing(4)
            Spacer()
            Button {
                cart.clear()
                dismiss()
            } label: {
                Text("Seguir comprando")
                    .font(.system(size: 16, weight: .bold)).frame(maxWidth: .infinity)
                    .padding(.vertical, 18).foregroundStyle(.white)
                    .background(Color.freshGreen, in: RoundedRectangle(cornerRadius: 18))
            }
            .buttonStyle(.plain).padding(.horizontal, 24).padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity)
    }
}
