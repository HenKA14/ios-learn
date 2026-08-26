import SwiftUI
import SwiftData

@main
struct testApp: App {
    @State private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            switch authViewModel.estado {
            case .autenticado:
                MainTabView(authViewModel: authViewModel)
            default:
                LoginView(authViewModel: authViewModel)
            }
        }
        .modelContainer(for: FavoriteProduct.self)
    }
}
