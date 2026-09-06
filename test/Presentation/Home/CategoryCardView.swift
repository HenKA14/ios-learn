import SwiftUI

/// Custom button style that scales down on press — applied to category cards.
struct PressScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

struct CategoryCardView: View {
    let category: Category

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: category.icono)
                .font(.system(size: 32))
                .foregroundStyle(.white)
            Text(category.nombre)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 110)
        .background(category.color.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
