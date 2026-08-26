import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query var favorites: [FavoriteProduct]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            Group {
                if favorites.isEmpty {
                    ContentUnavailableView(
                        "Sin favoritos",
                        systemImage: "heart.slash",
                        description: Text("Agrega productos desde el detalle")
                    )
                } else {
                    List {
                        ForEach(favorites) { fav in
                            FavoriteRowView(favorite: fav)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { modelContext.delete(favorites[$0]) }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favoritos")
            .toolbar {
                if !favorites.isEmpty { EditButton() }
            }
        }
    }
}

private struct FavoriteRowView: View {
    let favorite: FavoriteProduct

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: favorite.image)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)

            VStack(alignment: .leading, spacing: 4) {
                Text(favorite.title).font(.subheadline).lineLimit(2)
                Text(favorite.category.capitalized).font(.caption).foregroundStyle(.secondary)
                Text(String(format: "$%.2f", favorite.price))
                    .font(.caption).fontWeight(.semibold).foregroundStyle(.green)
            }
        }
        .padding(.vertical, 4)
    }
}
