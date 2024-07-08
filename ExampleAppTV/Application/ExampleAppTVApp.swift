//
//  ExampleAppTVApp.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 20.06.2024.
//


import SwiftUI
import Firebase

@main
struct ExampleAppTVApp: App {
    init() {
        FirebaseApp.configure()
        }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
