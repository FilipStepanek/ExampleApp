//
//  AboutRecommendationsView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 08.07.2024.
//

import SwiftUI
import OSLog

struct AboutRecommendationsView: View {
    var body: some View {
        ZStack {
            
            BackgroundGradientView()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center) {
                    Text("about.RecommendationsView.Title")
                        .modifier(SettingsHeadlineModifier())
                        .padding(.bottom, 60)
                    
                    Text("about.Recommendations.add.text")
                        .modifier(SettingsTextModifier())
                    
                }
                .padding(.top, 50)
            }
        }
    }
}

#if DEBUG
#Preview {
    AboutRecommendationsView()
}
#endif
