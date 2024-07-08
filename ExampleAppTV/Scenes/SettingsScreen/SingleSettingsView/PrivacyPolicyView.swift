//
//  PrivacyPolicyView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 08.07.2024.
//

import SwiftUI
import OSLog

struct PrivacyPolicyView: View {
    var body: some View {
        ZStack {
            
            BackgroundGradientView()
            
            VStack(alignment: .center) {
                Text("privacy.Policy.Title")
                    .modifier(SettingsHeadlineModifier())
                    .padding(.bottom, 60)
                
                Text("privacy.Policy.text")
                    .modifier(SettingsTextModifier())
                
                
                Text("privacy.Policy.adress")
                    .modifier(SettingsTextModifier())
                    .padding(.top, 10)
            }
        }
    }
}

#if DEBUG
#Preview {
    PrivacyPolicyView()
}
#endif
