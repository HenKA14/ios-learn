import SwiftUI

// MARK: - Hero banner with 3D floating food

struct FloatingHeroView: View {
    private struct HeroItem {
        let emoji: String
        let x: CGFloat
        let y: CGFloat
        let size: CGFloat
        let delay: Double
        let rotationDeg: Double
    }

    // Large items arranged in a "bloom" pattern around the basket
    private let items: [HeroItem] = [
        HeroItem(emoji: "🥑", x: -14, y: -70, size: 54, delay: 0.00, rotationDeg:  -15),
        HeroItem(emoji: "🍎", x:  36, y: -56, size: 48, delay: 0.35, rotationDeg:   12),
        HeroItem(emoji: "🍋", x: -62, y:  -6, size: 44, delay: 0.70, rotationDeg:  -20),
        HeroItem(emoji: "🥦", x:  56, y:   6, size: 50, delay: 0.20, rotationDeg:   18),
        HeroItem(emoji: "🍊", x: -18, y:  62, size: 44, delay: 0.85, rotationDeg:  -10),
        HeroItem(emoji: "🍇", x:  38, y:  56, size: 48, delay: 0.50, rotationDeg:    8),
    ]

    var body: some View {
        ZStack {
            heroBackground
            contentRow
        }
        // No .clipped() so items can overflow the card bounds
    }

    // MARK: - Background

    private var heroBackground: some View {
        RoundedRectangle(cornerRadius: 28)
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 0.82, green: 0.96, blue: 0.85),
                        Color(red: 0.72, green: 0.92, blue: 0.78),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(height: 210)
    }

    // MARK: - Content

    private var contentRow: some View {
        HStack(alignment: .center, spacing: 0) {
            heroText
                .padding(.leading, 24)
                .frame(maxWidth: .infinity, alignment: .leading)

            basketCluster
                .frame(width: 148)
                .padding(.trailing, 4)
        }
        .frame(height: 210)
    }

    private var heroText: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Fresh\nGroceries\nDelivered.")
                .font(.system(size: 22, weight: .black))
                .foregroundStyle(Color.freshDarkGreen)
                .lineSpacing(2)

            ctaButton
        }
    }

    private var ctaButton: some View {
        HStack(spacing: 6) {
            Text("Pedir ahora")
                .font(.system(size: 13, weight: .bold))
            Image(systemName: "arrow.right")
                .font(.system(size: 11, weight: .bold))
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .background(Color.freshGreen, in: Capsule())
        .shadow(color: Color.freshGreen.opacity(0.35), radius: 8, x: 0, y: 4)
    }

    // MARK: - Basket + floating items

    private var basketCluster: some View {
        ZStack {
            // Drop shadow underneath the basket
            Ellipse()
                .fill(.black.opacity(0.08))
                .frame(width: 70, height: 14)
                .offset(y: 46)
                .blur(radius: 4)

            Text("🧺")
                .font(.system(size: 78))
                .shadow(color: .black.opacity(0.14), radius: 10, x: 2, y: 8)

            ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                FloatingFoodItem(
                    emoji: item.emoji,
                    size: item.size,
                    delay: item.delay,
                    rotationDeg: item.rotationDeg
                )
                .offset(x: item.x, y: item.y)
            }
        }
    }
}

// MARK: - Animated food emoji

struct FloatingFoodItem: View {
    let emoji: String
    let size: CGFloat
    let delay: Double
    let rotationDeg: Double

    @State private var isUp = false

    var body: some View {
        Text(emoji)
            .font(.system(size: size))
            .rotationEffect(.degrees(rotationDeg))
            // Shadow distance increases when item is "up" (looks like height from surface)
            .shadow(color: .black.opacity(0.22), radius: isUp ? 12 : 4, x: 0, y: isUp ? 10 : 3)
            .scaleEffect(isUp ? 1.06 : 0.95)
            .offset(y: isUp ? -10 : 10)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 1.6 + delay * 0.3)
                    .repeatForever(autoreverses: true)
                    .delay(delay)
                ) {
                    isUp = true
                }
            }
    }
}
