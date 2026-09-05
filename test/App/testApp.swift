import SwiftUI

@main
struct testApp: App {
    @State private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            switch authViewModel.estado {
            case .autenticado:
                HomeView(authViewModel: authViewModel)
            default:
                LoginView(authViewModel: authViewModel)
            }
        }
    }
}
