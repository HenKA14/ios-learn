import SwiftUI

struct ProductCard: View {
    let product: Product
    @EnvironmentObject private var cart: CartStore

    private var qty: Int { cart.quantity(for: product) }

    var body: some View {
        NavigationLink {
            ProductDetailView(product: product)
        } label: {
            VStack(spacing: 0) {
                imageSection
                infoSection
            }
            .background(.white, in: RoundedRectangle(cornerRadius: 24))
            .shadow(color: .black.opacity(0.07), radius: 12, x: 0, y: 4)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Image oval container (pill-shaped, matches design)

    private var imageSection: some View {
        ZStack {
            // Pill-shaped gradient background
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.90, green: 0.98, blue: 0.92),
                            Color(red: 0.84, green: 0.96, blue: 0.87),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 130)
                .padding(.horizontal, 8)
                .padding(.top, 8)

            Text(product.emoji)
                .font(.system(size: 66))
                // Bigger shadow = more 3D-looking
                .shadow(color: .black.opacity(0.16), radius: 12, x: 2, y: 8)
                .padding(.top, 8)
        }
    }

    // MARK: - Name, price, quantity

    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(product.name)
                .font(.system(size: 14, weight: .semibold))
                .lineLimit(1)

            Text(product.weight)
                .font(.system(size: 11))
                .foregroundStyle(.secondary)

            HStack(alignment: .center) {
                Text(String(format: "$%.2f", product.price))
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color.freshGreen)
                Spacer()
                // Nested Buttons inside NavigationLink intercept their own taps
                quantityControl
            }
            .padding(.top, 5)
        }
        .padding(.horizontal, 14)
        .padding(.bottom, 12)
        .padding(.top, 8)
    }

    // MARK: - Quantity control

    @ViewBuilder
    private var quantityControl: some View {
        if qty > 0 {
            HStack(spacing: 5) {
                cardBtn(symbol: "minus", filled: false) {
                    withAnimation(.spring(response: 0.25)) { cart.remove(product) }
                }
                Text("\(qty)").font(.system(size: 12, weight: .bold)).frame(minWidth: 12)
                cardBtn(symbol: "plus", filled: true) {
                    withAnimation(.spring(response: 0.25)) { cart.add(product) }
                }
            }
            .transition(.scale(scale: 0.8).combined(with: .opacity))
        } else {
            cardBtn(symbol: "plus", filled: true, size: 30) {
                withAnimation(.spring(response: 0.25)) { cart.add(product) }
            }
            .transition(.scale(scale: 0.8).combined(with: .opacity))
        }
    }

    private func cardBtn(symbol: String, filled: Bool, size: CGFloat = 26, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: 10, weight: .bold))
                .frame(width: size, height: size)
                .foregroundStyle(filled ? .white : Color.freshGreen)
                .background(
                    (filled ? Color.freshGreen : Color(red: 0.88, green: 0.97, blue: 0.90)),
                    in: Circle()
                )
        }
        .buttonStyle(.plain)
    }
}
