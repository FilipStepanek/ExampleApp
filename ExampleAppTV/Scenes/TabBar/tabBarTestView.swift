//
//  tabBarTest.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 27.06.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
//            BacgroundGradientView()
            
            VStack {
                Text("Home")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
}

//struct YourLibraryView: View {
//    var body: some View {
//        ZStack {
////            BacgroundGradientView()
//            
//            Text("Your Library")
//                .font(.largeTitle)
//                .foregroundColor(.white)
//        }
//    }
//}

struct SearchView: View {
    var body: some View {
        ZStack {
//            BacgroundGradientView()
            
            Text("Search")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct SettingsView: View {
    @State private var showAnimation = true
    
    var body: some View {
        ZStack {
//            BacgroundGradientView()
            
            Text("Settings")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}


