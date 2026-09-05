import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 280)

                VStack(alignment: .leading, spacing: 8) {
                    Text(product.category.capitalized)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)

                    Text(product.title)
                        .font(.title2)
                        .fontWeight(.bold)

                    HStack {
                        Text(String(format: "$%.2f", product.price))
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.green)
                        Spacer()
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill").foregroundStyle(.yellow)
                            Text(String(format: "%.1f", product.rating.rate))
                            Text("(\(product.rating.count))").foregroundStyle(.secondary)
                        }
                        .font(.subheadline)
                    }

                    Divider()

                    Text(product.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle("Detalle")
    }
}
