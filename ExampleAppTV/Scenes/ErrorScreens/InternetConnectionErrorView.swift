//
//  InternetConnectionErrorView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 08.07.2024.
//

import SwiftUI

struct InternetConnectionErrorView: View {
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                Image.systemNetworkError
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("error.Internet.Connection.Title")
                    .modifier(HadlineLoginScreenModifier())
                    .padding()
                
                Text("error.Internet.Connection..Message")
                    .modifier(TextLoginScreenModifier())
                    .padding(.bottom, 60)
            }
        }
    }
}

#if DEBUG
#Preview {
    InternetConnectionErrorView()
}
#endif
