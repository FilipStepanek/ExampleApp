//
//  LaunchScreenView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 28.06.2024.
//

//MARK: View DONE
import SwiftUI

struct LaunchScreenView: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            Text("logo.LaunchScreen")
                .modifier(LogoModifier())
                .foregroundColor(.white)
                .kerning(20)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                        scale = 1.2
                    }
                }
        }
    }
}

#if DEBUG
#Preview {
    LaunchScreenView()
}
#endif


