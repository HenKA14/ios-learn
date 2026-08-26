import SwiftUI

struct MainTabView: View {
    let authViewModel: AuthViewModel
    @State private var cartViewModel = CartViewModel()

    var body: some View {
        TabView {
            HomeView(authViewModel: authViewModel)
                .tabItem { Label("Tiendas", systemImage: "storefront") }

            FavoritesView()
                .tabItem { Label("Favoritos", systemImage: "heart.fill") }

            CartView()
                .tabItem { Label("Carrito", systemImage: "cart.fill") }
                .badge(cartViewModel.totalItems)

            ProfileView(authViewModel: authViewModel)
                .tabItem { Label("Perfil", systemImage: "person.fill") }
        }
        .environment(cartViewModel)
    }
}
