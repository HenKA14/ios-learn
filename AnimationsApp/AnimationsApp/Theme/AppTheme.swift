import SwiftUI

extension Color {
    static let freshGreen      = Color(red: 0.18, green: 0.72, blue: 0.38)
    static let freshBackground = Color(red: 0.97, green: 1.00, blue: 0.98) // near-white like the design
    static let freshCard       = Color(red: 0.90, green: 0.98, blue: 0.92)
    static let freshDarkGreen  = Color(red: 0.06, green: 0.26, blue: 0.12)
}

extension View {
    /// Applies iOS-only keyboard and autocapitalization settings for email fields.
    @ViewBuilder
    func emailFieldStyle() -> some View {
        self
            .autocorrectionDisabled()
            .textContentType(.emailAddress)
        #if os(iOS)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
        #endif
    }
}
