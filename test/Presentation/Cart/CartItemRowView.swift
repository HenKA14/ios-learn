import SwiftUI

struct CartItemRowView: View {
    let item: CartViewModel.CartItem
    @Environment(CartViewModel.self) private var cartViewModel

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: item.product.image)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.product.title).font(.subheadline).lineLimit(2)
                Text(String(format: "$%.2f", item.product.price))
                    .font(.caption).fontWeight(.semibold).foregroundStyle(.green)
            }

            Spacer()

            HStack(spacing: 10) {
                Button {
                    cartViewModel.decrementar(item)
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.title3)
                }
                .buttonStyle(.plain)

                Text("\(item.cantidad)")
                    .font(.headline)
                    .frame(minWidth: 20)

                Button {
                    cartViewModel.agregar(item.product)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                }
                .buttonStyle(.plain)
            }
            .foregroundStyle(.blue)
        }
        .padding(.vertical, 4)
    }
}
