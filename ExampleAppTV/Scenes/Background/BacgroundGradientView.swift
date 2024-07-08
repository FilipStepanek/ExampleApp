//
//  BacgroundGradientView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 28.06.2024.
//

//MARK: View DONE
import SwiftUI

struct BackgroundGradientView: View {
    var body: some View {
        ZStack {
            gradientView
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    @ViewBuilder
    var gradientView: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.gradientFour,
                Color.gradientOne,
                Color.gradientTwo,
                Color.gradientThree
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
#Preview {
    BackgroundGradientView()
}
#endif

