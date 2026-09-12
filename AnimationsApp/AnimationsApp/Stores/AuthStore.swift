import Combine

class AuthStore: ObservableObject {
    @Published private(set) var isLoggedIn = false
    @Published private(set) var currentEmail = ""

    func login(email: String, password: String) {
        currentEmail = email
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
        currentEmail = ""
    }
}
