//
//  TermsConditionsView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 08.07.2024.
//

import SwiftUI
import OSLog

struct TermsConditionsView: View {
    var body: some View {
        ZStack {
            
            BackgroundGradientView()
            
            VStack(alignment: .center) {
                Text("terms.Conditions.Title")
                    .modifier(SettingsHeadlineModifier())
                    .padding(.bottom, 60)
                
                Text("terms.Conditions.text")
                    .modifier(SettingsTextModifier())
                
                
                Text("terms.Conditions.adress")
                    .modifier(SettingsTextModifier())
                    .padding(.top, 10)
                
                @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
            }
        }
    }
}

#if DEBUG
#Preview {
    TermsConditionsView()
}
#endif
