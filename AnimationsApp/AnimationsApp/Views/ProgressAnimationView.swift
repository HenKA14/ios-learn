import SwiftUI

struct ProgressAnimationView: View {
    @State private var p1 = 0.0
    @State private var p2 = 0.0
    @State private var p3 = 0.0
    @State private var animated = false

    var body: some View {
        ScrollView {
            VStack(spacing: 36) {

                // linear — easeInOut
                ProgressSection(title: "easeInOut", subtitle: ".easeInOut(duration: 1.4)") {
                    LinearBar(progress: p1, color: .blue)
                    PercentLabel(value: p1)
                }

                // spring — bouncy
                ProgressSection(title: "Spring bounce", subtitle: ".spring(response: 1.4, dampingFraction: 0.45)") {
                    LinearBar(progress: p2, color: .purple)
                    PercentLabel(value: p2)
                }

                // circular
                ProgressSection(title: "Circular", subtitle: ".easeOut(duration: 1.8)") {
                    CircularBar(progress: p3, color: .teal)
                        .frame(width: 140, height: 140)
                }

                Button(animated ? "Reiniciar" : "Animar") {
                    if animated {
                        p1 = 0; p2 = 0; p3 = 0
                        animated = false
                    } else {
                        withAnimation(.easeInOut(duration: 1.4))                                  { p1 = 0.78 }
                        withAnimation(.spring(response: 1.4, dampingFraction: 0.45).delay(0.15)) { p2 = 0.62 }
                        withAnimation(.easeOut(duration: 1.8).delay(0.3))                        { p3 = 0.91 }
                        animated = true
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(24)
        }
        .navigationTitle("Progress")
    }
}

private struct ProgressSection<Content: View>: View {
    let title: String
    let subtitle: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.headline)
                Text(subtitle).font(.caption).foregroundStyle(.secondary)
            }
            content
        }
    }
}

private struct LinearBar: View {
    let progress: Double
    let color: Color

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8).fill(.quaternary).frame(height: 16)
                RoundedRectangle(cornerRadius: 8)
                    .fill(color.gradient)
                    .frame(width: geo.size.width * progress, height: 16)
            }
        }
        .frame(height: 16)
    }
}

private struct PercentLabel: View {
    let value: Double
    var body: some View {
        Text("\(Int(value * 100))%").font(.caption).foregroundStyle(.secondary)
    }
}

private struct CircularBar: View {
    let progress: Double
    let color: Color

    var body: some View {
        ZStack {
            Circle().stroke(.quaternary, lineWidth: 14)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(color.gradient, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text("\(Int(progress * 100))%")
                .font(.title2).fontWeight(.bold)
        }
    }
}
