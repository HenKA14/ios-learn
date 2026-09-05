import SwiftUI

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
