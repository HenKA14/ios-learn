import SwiftUI

struct HeroTransitionView: View {
    @Namespace private var ns
    @State private var selected: HeroItem?

    private let items = HeroItem.samples

    var body: some View {
        ZStack {
            // grid
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                    ForEach(items) { item in
                        if selected?.id != item.id {
                            GridCell(item: item, ns: ns) {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.78)) {
                                    selected = item
                                }
                            }
                        } else {
                            Color.clear.frame(height: 100)
                        }
                    }
                }
                .padding()
            }

            // expanded detail
            if let item = selected {
                ExpandedCard(item: item, ns: ns) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.78)) {
                        selected = nil
                    }
                }
                .zIndex(1)
            }
        }
        .navigationTitle("Hero Transition")
    }
}

private struct HeroItem: Identifiable {
    let id = UUID()
    let label: String
    let color: Color

    static let samples = [
        HeroItem(label: "Ocean",    color: .blue),
        HeroItem(label: "Sunset",   color: .orange),
        HeroItem(label: "Forest",   color: .green),
        HeroItem(label: "Berry",    color: .purple),
        HeroItem(label: "Rose",     color: .pink),
        HeroItem(label: "Sky",      color: .cyan),
    ]
}

private struct GridCell: View {
    let item: HeroItem
    let ns: Namespace.ID
    let onTap: () -> Void

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(item.color.gradient)
            .matchedGeometryEffect(id: item.id, in: ns)
            .frame(height: 100)
            .overlay {
                Text(item.label)
                    .font(.caption).fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            .onTapGesture { onTap() }
    }
}

private struct ExpandedCard: View {
    let item: HeroItem
    let ns: Namespace.ID
    let onDismiss: () -> Void

    var body: some View {
        RoundedRectangle(cornerRadius: 28)
            .fill(item.color.gradient)
            .matchedGeometryEffect(id: item.id, in: ns)
            .overlay {
                VStack(spacing: 20) {
                    Text(item.label)
                        .font(.largeTitle).fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("matchedGeometryEffect sincroniza la geometría de esta tarjeta con la celda del grid, creando la ilusión de una transición continua.")
                        .font(.body)
                        .foregroundStyle(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                    Button("Cerrar") { onDismiss() }
                        .buttonStyle(.bordered)
                        .tint(.white)
                }
            }
            .padding(20)
    }
}
