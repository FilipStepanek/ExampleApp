//
//  CopyrightPolicy.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 08.07.2024.
//

import SwiftUI
import OSLog

struct CopyrightPolicyView: View {
    var body: some View {
        ZStack {
            
            BackgroundGradientView()
            
            VStack(alignment: .center) {
                Text("copyright.Poicy.Title")
                    .modifier(SettingsHeadlineModifier())
                    .padding(.bottom, 60)
                
                Text("copyright.Poicy.text")
                    .modifier(SettingsTextModifier())
                
                
                Text("copyright.Poicy.adress")
                    .modifier(SettingsTextModifier())
                    .padding(.top, 10)
            }
        }
    }
}

#if DEBUG
#Preview {
    CopyrightPolicyView()
}
#endif
