import SwiftUI

struct RootView: View {
    @EnvironmentObject private var auth: AuthStore
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some View {
        ZStack {
            if !hasSeenOnboarding {
                OnboardingView()
                    .transition(.opacity)
            } else if auth.isLoggedIn {
                HomeView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .opacity
                    ))
            } else {
                LoginView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .opacity
                    ))
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.85), value: hasSeenOnboarding)
        .animation(.spring(response: 0.5, dampingFraction: 0.85), value: auth.isLoggedIn)
    }
}
