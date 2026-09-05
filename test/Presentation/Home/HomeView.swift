import SwiftUI

struct HomeView: View {
    let authViewModel: AuthViewModel
    private let columns = [GridItem(.adaptive(minimum: 140), spacing: 14)]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(Category.all) { category in
                        NavigationLink(destination: ProductListView(category: category)) {
                            CategoryCardView(category: category)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Tiendas")
            .toolbar {
                ToolbarItem {
                    Button("Cerrar sesión") { authViewModel.logout() }
                }
            }
        }
    }
}

#Preview {
    HomeView(authViewModel: AuthViewModel())
}
