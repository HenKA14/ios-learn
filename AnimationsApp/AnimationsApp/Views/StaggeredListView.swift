import SwiftUI

struct StaggeredListView: View {
    @State private var visible = false

    private let items: [(icon: String, label: String, value: String)] = [
        ("person.fill",                 "Usuarios activos",  "1,234"),
        ("cart.fill",                   "Ventas hoy",        "$8,459"),
        ("star.fill",                   "Valoración",        "4.9"),
        ("chart.line.uptrend.xyaxis",   "Crecimiento",       "+23%"),
        ("bell.fill",                   "Notificaciones",    "12"),
        ("globe",                       "Países",            "42"),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    StatRow(icon: item.icon, label: item.label, value: item.value)
                        .opacity(visible ? 1 : 0)
                        .offset(x: visible ? 0 : -50)
                        .animation(
                            .spring(response: 0.5, dampingFraction: 0.7)
                            .delay(Double(index) * 0.09),
                            value: visible
                        )
                }
            }
            .padding()
        }
        .navigationTitle("Staggered List")
        .toolbar {
            Button("Replay") {
                visible = false
                Task {
                    try? await Task.sleep(for: .milliseconds(100))
                    visible = true
                }
            }
        }
        .onAppear { visible = true }
    }
}

private struct StatRow: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 46, height: 46)
                .background(.blue.gradient, in: Circle())

            Text(label).font(.body)
            Spacer()
            Text(value)
                .font(.headline).foregroundStyle(.blue)
        }
        .padding()
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 12))
    }
}
