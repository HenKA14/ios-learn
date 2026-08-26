import SwiftUI

struct CartView: View {
    @Environment(CartViewModel.self) private var cartViewModel

    var body: some View {
        NavigationStack {
            Group {
                if cartViewModel.items.isEmpty {
                    ContentUnavailableView(
                        "Carrito vacío",
                        systemImage: "cart",
                        description: Text("Agrega productos desde el detalle")
                    )
                } else {
                    List {
                        ForEach(cartViewModel.items) { item in
                            CartItemRowView(item: item)
                        }

                        Section {
                            HStack {
                                Text("Total").fontWeight(.bold)
                                Spacer()
                                Text(String(format: "$%.2f", cartViewModel.totalPrecio))
                                    .fontWeight(.bold).foregroundStyle(.green)
                            }
                            Button("Vaciar carrito", role: .destructive) {
                                cartViewModel.vaciar()
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Carrito")
        }
    }
}
