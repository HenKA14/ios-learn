import SwiftUI

struct FilterView: View {
    @Binding var precioMax: Double
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Precio máximo")
                            Spacer()
                            Text(String(format: "$%.0f", precioMax))
                                .fontWeight(.semibold)
                                .foregroundStyle(.blue)
                        }
                        Slider(value: $precioMax, in: 10...1000, step: 10)
                    }
                    .padding(.vertical, 4)
                } header: {
                    Text("Rango de precio")
                }

                Section {
                    Button("Limpiar filtros", role: .destructive) {
                        precioMax = 1000
                    }
                }
            }
            .navigationTitle("Filtros")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Aplicar") { dismiss() }
                }
            }
        }
    }
}
