import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var goingForward = true

    private let pages: [OBPage] = [
        OBPage(icon: "figure.walk",     title: "Bienvenido",      body: "Esta app demuestra el sistema de animaciones de SwiftUI de punta a punta.",     color: .purple),
        OBPage(icon: "paintbrush.fill", title: "Smooth & Fluid",  body: "Transiciones suaves entre pantallas con .transition() y AnyTransition.",         color: .blue),
        OBPage(icon: "bolt.fill",       title: "Spring Physics",  body: "Animaciones con física real: duración, damping y stiffness controlados.",         color: .orange),
    ]

    var body: some View {
        VStack(spacing: 0) {
            // page content with slide transition
            ZStack {
                ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                    if index == currentPage {
                        PageView(page: page)
                            .transition(
                                .asymmetric(
                                    insertion: .move(edge: goingForward ? .trailing : .leading).combined(with: .opacity),
                                    removal:   .move(edge: goingForward ? .leading  : .trailing).combined(with: .opacity)
                                )
                            )
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()

            // controls
            HStack(spacing: 24) {
                Button("Anterior") { navigate(to: currentPage - 1) }
                    .disabled(currentPage == 0)

                Spacer()

                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Capsule()
                            .fill(index == currentPage ? Color.accentColor : Color.secondary.opacity(0.35))
                            .frame(width: index == currentPage ? 20 : 8, height: 8)
                            .animation(.spring(response: 0.35), value: currentPage)
                    }
                }

                Spacer()

                Button(currentPage == pages.count - 1 ? "Listo" : "Siguiente") {
                    navigate(to: currentPage + 1)
                }
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 32)
        }
        .navigationTitle("Onboarding")
    }

    private func navigate(to page: Int) {
        guard pages.indices.contains(page) else { return }
        goingForward = page > currentPage
        withAnimation(.spring(response: 0.5, dampingFraction: 0.78)) {
            currentPage = page
        }
    }
}

private struct OBPage {
    let icon: String
    let title: String
    let body: String
    let color: Color
}

private struct PageView: View {
    let page: OBPage

    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: page.icon)
                .font(.system(size: 80))
                .foregroundStyle(page.color)
                .symbolEffect(.bounce)

            VStack(spacing: 12) {
                Text(page.title)
                    .font(.largeTitle).fontWeight(.bold)
                Text(page.body)
                    .font(.body).foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
