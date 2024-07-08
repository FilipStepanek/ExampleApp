//
//  ContentView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 20.06.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = MusicPlayerViewModel()
    @State private var showAnimation = true
    
    var body: some View {
        ZStack {
            if showAnimation {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.4) {
                            withAnimation {
                                showAnimation = false
                            }
                        }
                    }
            } else {
                tabBarView()
                    .transition(.opacity)
            }
        }
    }
}
    
#if DEBUG
#Preview {
    ContentView()
}
#endif

//import SwiftUI
//
//struct ContentView: View {
//    
//    var body: some View {
//        ZStack {
//           LoginView()
//        }
//    }
//}
    
//#if DEBUG
//#Preview {
//    ContentView()
//}
//#endif
