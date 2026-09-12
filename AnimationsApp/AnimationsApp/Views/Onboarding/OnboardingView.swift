import SwiftUI

// MARK: - Slide data (file-private)

private struct OnboardingSlide {
    let mainEmoji: String
    let floaters: [(emoji: String, x: CGFloat, y: CGFloat, size: CGFloat, delay: Double, rotation: Double)]
    let title: String
    let subtitle: String
    let gradientColors: [Color]
}

private let slides: [OnboardingSlide] = [
    OnboardingSlide(
        mainEmoji: "🛒",
        floaters: [
            (emoji: "🥑", x: -88, y: -30, size: 38, delay: 0.0, rotation: -15),
            (emoji: "🍎", x:  80, y: -22, size: 34, delay: 0.3, rotation:  12),
            (emoji: "🍋", x: -70, y:  42, size: 30, delay: 0.6, rotation: -10),
            (emoji: "🥦", x:  68, y:  38, size: 36, delay: 0.9, rotation:  18),
        ],
        title: "Todo fresco,\nsiempre.",
        subtitle: "El mejor mercado digital con productos seleccionados cada mañana.",
        gradientColors: [Color(red: 0.82, green: 0.97, blue: 0.86), Color(red: 0.70, green: 0.92, blue: 0.77)]
    ),
    OnboardingSlide(
        mainEmoji: "🚚",
        floaters: [
            (emoji: "📦", x: -85, y: -28, size: 34, delay: 0.2, rotation: -12),
            (emoji: "⏱️", x:  78, y: -24, size: 32, delay: 0.5, rotation:  10),
            (emoji: "🗺️", x: -68, y:  44, size: 30, delay: 0.8, rotation:  -8),
            (emoji: "📍", x:  72, y:  38, size: 30, delay: 0.1, rotation:  14),
        ],
        title: "30 minutos\ndesde la huerta.",
        subtitle: "Seguí tu pedido en tiempo real mientras llega a tu puerta.",
        gradientColors: [Color(red: 0.82, green: 0.92, blue: 0.99), Color(red: 0.70, green: 0.85, blue: 0.97)]
    ),
    OnboardingSlide(
        mainEmoji: "💚",
        floaters: [
            (emoji: "🌱", x: -85, y: -28, size: 36, delay: 0.3, rotation: -10),
            (emoji: "✨", x:  78, y: -26, size: 32, delay: 0.0, rotation:   0),
            (emoji: "🌿", x: -68, y:  44, size: 30, delay: 0.7, rotation:  12),
            (emoji: "⭐️", x:  70, y:  40, size: 30, delay: 0.5, rotation:  -8),
        ],
        title: "Fresco cada\nmañana.",
        subtitle: "Seleccionamos los mejores productos locales para vos.",
        gradientColors: [Color(red: 0.84, green: 0.97, blue: 0.88), Color(red: 0.74, green: 0.94, blue: 0.80)]
    ),
]

// MARK: - Main onboarding container

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var currentPage = 0

    var body: some View {
        ZStack {
            animatedBackground
            VStack(spacing: 0) {
                skipButton
                pageCarousel
                bottomControls
            }
        }
    }

    // MARK: Background (color shifts between slides)

    private var animatedBackground: some View {
        LinearGradient(
            colors: slides[currentPage].gradientColors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 0.5), value: currentPage)
    }

    // MARK: Skip

    private var skipButton: some View {
        HStack {
            Spacer()
            if currentPage < slides.count - 1 {
                Button("Omitir") { hasSeenOnboarding = true }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.secondary)
                    .padding(.trailing, 24)
                    .transition(.opacity)
            }
        }
        .frame(height: 44)
        .padding(.top, 12)
        .animation(.easeInOut(duration: 0.2), value: currentPage)
    }

    // MARK: Slides

    private var pageCarousel: some View {
        TabView(selection: $currentPage) {
            ForEach(Array(slides.enumerated()), id: \.offset) { index, slide in
                SlideView(slide: slide)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    // MARK: Dots + CTA

    private var bottomControls: some View {
        VStack(spacing: 24) {
            pageDots
            ctaButton
        }
        .padding(.bottom, 44)
    }

    private var pageDots: some View {
        HStack(spacing: 8) {
            ForEach(0..<slides.count, id: \.self) { i in
                Capsule()
                    .fill(i == currentPage ? Color.freshGreen : Color.freshGreen.opacity(0.25))
                    .frame(width: i == currentPage ? 26 : 8, height: 8)
                    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: currentPage)
            }
        }
    }

    private var ctaButton: some View {
        Button {
            if currentPage < slides.count - 1 {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                    currentPage += 1
                }
            } else {
                withAnimation(.easeInOut(duration: 0.4)) {
                    hasSeenOnboarding = true
                }
            }
        } label: {
            HStack(spacing: 8) {
                Text(currentPage == slides.count - 1 ? "¡Empezar!" : "Siguiente")
                    .font(.system(size: 16, weight: .bold))
                Image(systemName: currentPage == slides.count - 1 ? "checkmark" : "arrow.right")
                    .font(.system(size: 14, weight: .bold))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .foregroundStyle(.white)
            .background(Color.freshGreen, in: RoundedRectangle(cornerRadius: 18))
            .shadow(color: Color.freshGreen.opacity(0.4), radius: 14, x: 0, y: 6)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 28)
        .animation(.none, value: currentPage)
    }
}

// MARK: - Individual slide

private struct SlideView: View {
    let slide: OnboardingSlide
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            emojiCluster
            Spacer()
            textBlock
            Spacer().frame(height: 36)
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.08)) {
                appeared = true
            }
        }
        .onDisappear { appeared = false }
    }

    // MARK: Emoji cluster

    private var emojiCluster: some View {
        ZStack {
            // Soft halo behind the main emoji
            Circle()
                .fill(.white.opacity(0.35))
                .frame(width: 220, height: 220)
                .scaleEffect(appeared ? 1.0 : 0.7)
                .opacity(appeared ? 1.0 : 0.0)

            // Main emoji — springs in from below
            Text(slide.mainEmoji)
                .font(.system(size: 100))
                .shadow(color: .black.opacity(0.18), radius: 18, x: 0, y: 10)
                .scaleEffect(appeared ? 1.0 : 0.5)
                .offset(y: appeared ? 0 : 30)

            // Satellite emojis — reuse FloatingFoodItem from FloatingHeroView
            ForEach(Array(slide.floaters.enumerated()), id: \.offset) { _, item in
                FloatingFoodItem(emoji: item.emoji, size: item.size, delay: item.delay, rotationDeg: item.rotation)
                    .offset(x: item.x, y: item.y)
                    .scaleEffect(appeared ? 1.0 : 0.2)
                    .opacity(appeared ? 1.0 : 0.0)
                    .animation(
                        .spring(response: 0.5, dampingFraction: 0.65).delay(0.2 + Double(slide.floaters.firstIndex(where: { $0.emoji == item.emoji }) ?? 0) * 0.08),
                        value: appeared
                    )
            }
        }
    }

    // MARK: Text block

    private var textBlock: some View {
        VStack(spacing: 12) {
            Text(slide.title)
                .font(.system(size: 38, weight: .black))
                .multilineTextAlignment(.center)
                .tracking(-1.5)
                .foregroundStyle(Color.freshDarkGreen)
                .offset(y: appeared ? 0 : 28)
                .opacity(appeared ? 1 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.22), value: appeared)

            Text(slide.subtitle)
                .font(.system(size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.freshDarkGreen.opacity(0.6))
                .lineSpacing(5)
                .padding(.horizontal, 36)
                .offset(y: appeared ? 0 : 18)
                .opacity(appeared ? 1 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.32), value: appeared)
        }
    }
}
