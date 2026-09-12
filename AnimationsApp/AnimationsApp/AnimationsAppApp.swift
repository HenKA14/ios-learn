//
//  AnimationsAppApp.swift
//  AnimationsApp
//
//  Created by Henrique Carhuapoma Capillo on 6/09/26.
//

import SwiftUI

@main
struct AnimationsAppApp: App {
    @StateObject private var auth = AuthStore()
    @StateObject private var cart = CartStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(auth)
                .environmentObject(cart)
        }
        #if os(macOS)
        .defaultSize(width: 390, height: 844)
        .windowStyle(.hiddenTitleBar)
        #endif
    }
}
