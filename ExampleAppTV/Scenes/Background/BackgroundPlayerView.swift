//
//  BackgroundPlayerView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 01.07.2024.
//

import SwiftUI

struct BackgroundPlayerView: View {
    var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    Image(.image6)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .ignoresSafeArea()
                    
                    VisualEffectView(effect: UIBlurEffect(style: .dark))
                        .edgesIgnoringSafeArea(.all)
                    
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]),
                                   startPoint: .top, endPoint: .bottom)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                        .opacity(1.0) // Adjust opacity as needed
                        .edgesIgnoringSafeArea(.bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .ignoresSafeArea(.all)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}


#if DEBUG
#Preview {
    BackgroundPlayerView()
}
#endif
