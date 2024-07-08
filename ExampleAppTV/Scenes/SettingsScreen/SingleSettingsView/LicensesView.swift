//
//  LicensesView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 08.07.2024.
//

import SwiftUI
import OSLog

struct LicensesView: View {
    var body: some View {
        ZStack {
            
            BackgroundGradientView()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center) {
                    Text("licenses.Title")
                        .modifier(SettingsHeadlineModifier())
                        .padding(.bottom, 60)
                    
                    Text("licesnes.add.text")
                        .modifier(SettingsTextModifier())
                    
                }
                .padding(.top, 50)
            }
        }
    }
}

#if DEBUG
#Preview {
    LicensesView()
}
#endif
