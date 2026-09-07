import SwiftUI

enum AnimationRoute: Hashable {
    case onboarding, cardFlip, staggered, particles, hero, progress
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 16) {
                    ForEach(DemoItem.all) { item in
                        NavigationLink(value: item.route) {
                            DemoCardView(item: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Animations Playground")
            .navigationDestination(for: AnimationRoute.self) { route in
                switch route {
                case .onboarding:   OnboardingView()
                case .cardFlip:     CardFlipView()
                case .staggered:    StaggeredListView()
                case .particles:    ParticlesView()
                case .hero:         HeroTransitionView()
                case .progress:     ProgressAnimationView()
                }
            }
        }
    }
}

struct DemoItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let route: AnimationRoute

    static let all: [DemoItem] = [
        DemoItem(title: "Onboarding",     subtitle: "Slide & fade transitions",       icon: "sparkles",                          color: .purple, route: .onboarding),
        DemoItem(title: "Card Flip",       subtitle: "rotation3DEffect",               icon: "rectangle.on.rectangle",           color: .blue,   route: .cardFlip),
        DemoItem(title: "Staggered List",  subtitle: "Sequential entrance",            icon: "list.bullet.indent",               color: .green,  route: .staggered),
        DemoItem(title: "Particles",       subtitle: "Canvas + TimelineView",          icon: "sparkle",                          color: .orange, route: .particles),
        DemoItem(title: "Hero Transition", subtitle: "matchedGeometryEffect",          icon: "arrow.up.left.and.arrow.down.right", color: .red,  route: .hero),
        DemoItem(title: "Progress",        subtitle: "Animated progress bars",         icon: "chart.bar.fill",                   color: .teal,   route: .progress),
    ]
}

private struct DemoCardView: View {
    let item: DemoItem

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: item.icon)
                .font(.system(size: 34))
                .foregroundStyle(item.color)
            Text(item.title)
                .font(.headline)
            Text(item.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .background(.quaternary, in: RoundedRectangle(cornerRadius: 16))
    }
}
