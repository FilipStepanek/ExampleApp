//
//  LoginView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 04.07.2024.
//

import SwiftUI
import OSLog

struct LoginView: View {
    var body: some View {
        ZStack{
            
            BackgroundGradientView()
            
            VStack(alignment: .center) {
                Text("logo.Login.Screen")
                    .modifier(LogoModifier())
                    .opacity(0.6)
                    .padding(.bottom, 60)
                
                Text("listen.TO.What.You.Love")
                    .modifier(HadlineLoginScreenModifier())
                    .padding()
                
                Text("login.Screen.Text")
                    .modifier(TextLoginScreenModifier())
                    .padding(.bottom, 60)
                
                loginButton
                
            }
        }
    }
    
    @ViewBuilder
    var loginButton: some View {
        Button(action: {
            Logger.viewCycle.info("Button pressed Share")
            //TODO: add action
            //                    showMusicPlayer = true
        }) {
            Text("button.Login")
                .modifier(ButtonLoginScreenModifier())
        }
        .buttonStyle(LoginCardButtonStyle())
        .buttonBorderShape(.capsule)
    }
}

#if DEBUG
#Preview {
    LoginView()
}
#endif
