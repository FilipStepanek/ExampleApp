//
//  LaunchAnimationView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 28.06.2024.
//

import SwiftUI

struct TestAnimationView: View {
    @State private var showAnimation = true
    
    var body: some View {
        ZStack {
            LottieView(animationFileName: "animation", loopMode: .loop)
                .frame(width: 200, height: 200)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        withAnimation {
                            showAnimation = false
                        }
                    }
                }
        }
    }
}

#if DEBUG
struct LaunchAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TestAnimationView()
    }
}
#endif
