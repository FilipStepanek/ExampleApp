//
//  ExampleAppApp.swift
//  ExampleApp
//
//  Created by Filip Štěpánek on 20.06.2024.
//

import SwiftUI
import Firebase

@main
struct ExampleAppApp: App {
    init() {
        FirebaseApp.configure()
        }

    var body: some Scene {
        WindowGroup {
            ContentView(expandSheet: .constant(true), animation: Namespace().wrappedValue)
        }
    }
}
