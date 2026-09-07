import SwiftUI

struct ParticlesView: View {
    @State private var isActive = false

    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.black)
                    .frame(height: 320)

                if isActive {
                    TimelineView(.animation) { timeline in
                        Canvas { ctx, size in
                            let t = timeline.date.timeIntervalSinceReferenceDate
                            let particleCount = 80

                            for i in 0..<particleCount {
                                let seed   = Double(i) * 0.618033
                                let angle  = seed * .pi * 2 + t * 0.4
                                let speed  = 0.4 + seed.truncatingRemainder(dividingBy: 0.6)
                                let phase  = (t * speed).truncatingRemainder(dividingBy: 3.0) / 3.0

                                let cx = size.width / 2
                                let cy = size.height * 0.45
                                let spread = min(size.width, size.height) * 0.42

                                let x = cx + cos(angle) * spread * phase
                                let y = cy - (phase * size.height * 0.55) + sin(angle * 2) * 20

                                let r = (1 - phase) * 7 + 1.5
                                let opacity = (1 - phase) * 0.9

                                let palette: [Color] = [.blue, .purple, .pink, .orange, .yellow, .cyan]
                                let color = palette[i % palette.count].opacity(opacity)

                                let rect = CGRect(x: x - r, y: y - r, width: r * 2, height: r * 2)
                                ctx.fill(Path(ellipseIn: rect), with: .color(color))
                            }
                        }
                    }
                } else {
                    Text("Pulsa para iniciar")
                        .foregroundStyle(.white.opacity(0.4))
                        .font(.subheadline)
                }
            }
            .padding(.horizontal)

            Text("Canvas dibuja 80 partículas por frame.\nTimelineView fuerza el redibujado en cada tick de animación.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(isActive ? "Detener" : "Iniciar partículas") {
                withAnimation(.easeInOut(duration: 0.3)) { isActive.toggle() }
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Particles")
    }
}
