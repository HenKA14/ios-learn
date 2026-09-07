import SwiftUI

struct CardFlipView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("Toca cualquier tarjeta para voltearla")
                    .font(.subheadline).foregroundStyle(.secondary)
                    .padding(.top, 8)

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                    ForEach(FlipCard.samples) { card in
                        FlippableCard(card: card)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Card Flip")
    }
}

private struct FlipCard: Identifiable {
    let id = UUID()
    let icon: String
    let label: String
    let detail: String
    let color: Color

    static let samples = [
        FlipCard(icon: "hammer.fill",       label: "Swift",     detail: "Lenguaje de Apple para todas las plataformas", color: .orange),
        FlipCard(icon: "iphone",            label: "iOS",       detail: "Sistema operativo para iPhone y iPod Touch",  color: .blue),
        FlipCard(icon: "laptopcomputer",    label: "macOS",     detail: "Sistema operativo para Mac",                  color: .purple),
        FlipCard(icon: "applewatch",        label: "watchOS",   detail: "Sistema operativo para Apple Watch",          color: .green),
        FlipCard(icon: "appletv",           label: "tvOS",      detail: "Sistema operativo para Apple TV",             color: .red),
        FlipCard(icon: "visionpro",         label: "visionOS",  detail: "Sistema operativo para Apple Vision Pro",     color: .teal),
    ]
}

private struct FlippableCard: View {
    let card: FlipCard
    @State private var flipped = false

    var body: some View {
        ZStack {
            // Front face
            RoundedRectangle(cornerRadius: 16)
                .fill(card.color.gradient)
                .overlay {
                    VStack(spacing: 10) {
                        Image(systemName: card.icon)
                            .font(.system(size: 44))
                            .foregroundStyle(.white)
                        Text(card.label)
                            .font(.headline).foregroundStyle(.white)
                    }
                }
                .opacity(flipped ? 0 : 1)
                .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))

            // Back face
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 16).stroke(card.color, lineWidth: 2)
                }
                .overlay {
                    VStack(spacing: 8) {
                        Text(card.label)
                            .font(.title2).fontWeight(.bold)
                        Text(card.detail)
                            .font(.caption).foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                    }
                }
                .opacity(flipped ? 1 : 0)
                .rotation3DEffect(.degrees(flipped ? 0 : -180), axis: (x: 0, y: 1, z: 0))
        }
        .frame(height: 160)
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.75)) {
                flipped.toggle()
            }
        }
    }
}
