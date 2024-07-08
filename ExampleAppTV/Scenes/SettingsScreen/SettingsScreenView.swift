//
//  SettingsScreenView.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 08.07.2024.
//

//import SwiftUI
//import OSLog
//
//struct SettingsScreenView: View {
//    
//    @State private var showTermsConditions = false
//    @State private var showPrivacyPolicy = false
//    @State private var showCopyrightPolicy = false
//    @State private var showLicenses = false
//    @State private var showAboutRecommendations = false
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                buttonTermsConditions
//                buttonPrivacyPolicy
//                buttonCopyrightPolicy
//                buttonLicenses
//                buttonAboutRecommendations
//                buttonLogOut
//                Spacer()
//            }
//            .padding(.top, 50)
//            .preferredColorScheme(.dark)
//            .background(
//                EmptyView()
//                    .hidden()
//                    .navigationDestination(isPresented: $showTermsConditions) {
//                        TermsConditionsView()
//                    }
//                    .navigationDestination(isPresented: $showPrivacyPolicy) {
//                        PrivacyPolicyView()
//                    }
//                    .navigationDestination(isPresented: $showCopyrightPolicy) {
//                        CopyrightPolicyView()
//                    }
//                    .navigationDestination(isPresented: $showLicenses) {
//                        LicensesView()
//                    }
//                    .navigationDestination(isPresented: $showAboutRecommendations) {
//                        AboutRecommendationsView()
//                    }
//            )
//        }
//    }
//    
//    @ViewBuilder
//    var buttonTermsConditions: some View {
//        Button(action: {
//            Logger.viewCycle.info("Button pressed Term & Conditions")
//            showTermsConditions = true
//        }) {
//            HStack {
//                Text("terms.Conditions.Title")
//                    .modifier(ButtonsSettingsScreenModifier())
//                Spacer()
//            }
//            .buttonStyle(CardButtonStyle())
//        }
//    }
//    
//    @ViewBuilder
//    var buttonPrivacyPolicy: some View {
//        Button(action: {
//            Logger.viewCycle.info("Button pressed Privacy Policy")
//            showPrivacyPolicy = true
//        }) {
//            HStack {
//                Text("privacy.Policy.Title")
//                    .modifier(ButtonsSettingsScreenModifier())
//                Spacer()
//            }
//            .buttonStyle(CardButtonStyle())
//        }
//    }
//    
//    @ViewBuilder
//    var buttonCopyrightPolicy: some View {
//        Button(action: {
//            Logger.viewCycle.info("Button pressed Copyright Policy")
//            showCopyrightPolicy = true
//        }) {
//            HStack {
//                Text("copyright.Policy.Title")
//                    .modifier(ButtonsSettingsScreenModifier())
//                Spacer()
//            }
//            .buttonStyle(CardButtonStyle())
//        }
//    }
//    
//    @ViewBuilder
//    var buttonLicenses: some View {
//        Button(action: {
//            Logger.viewCycle.info("Button pressed Licenses")
//            showLicenses = true
//        }) {
//            HStack {
//                Text("licenses.Title")
//                    .modifier(ButtonsSettingsScreenModifier())
//                Spacer()
//            }
//            .buttonStyle(CardButtonStyle())
//        }
//    }
//    
//    @ViewBuilder
//    var buttonAboutRecommendations: some View {
//        Button(action: {
//            Logger.viewCycle.info("Button pressed About Recommendations")
//            showAboutRecommendations = true
//        }) {
//            HStack {
//                Text("about.Recommendations.Title")
//                    .modifier(ButtonsSettingsScreenModifier())
//                Spacer()
//            }
//            .buttonStyle(CardButtonStyle())
//        }
//    }
//    
//    @ViewBuilder
//    var buttonLogOut: some View {
//        Button(action: {
//            Logger.viewCycle.info("Button pressed Log Out")
//            // TODO: add log out action
//        }) {
//            HStack {
//                Text("log.Out.Title")
//                    .modifier(ButtonsSettingsScreenModifier())
//                Spacer()
//                Text("user.name")
//                    .modifier(ButtonsSettingsScreenModifier())
//            }
//            .buttonStyle(CardButtonStyle())
//        }
//    }
//}
//
//#if DEBUG
//#Preview {
//    SettingsScreenView()
//}
//#endif

import SwiftUI
import OSLog

struct SettingsScreenView: View {
    
    @State private var showTermsConditions = false
    @State private var showPrivacyPolicy = false
    @State private var showCopyrightPolicy = false
    @State private var showLicenses = false
    @State private var showAboutRecommendations = false
    
    var body: some View {
        VStack {
            buttonTermsConditions
            buttonPrivacyPolicy
            buttonCopyrightPolicy
            buttonLicenses
            buttonAboutRecommendations
            buttonLogOut
            Spacer()
        }
        .padding(.top, 50)
        .preferredColorScheme(.dark)
        
        .sheet(isPresented: $showTermsConditions) {
            TermsConditionsView()
        }
        .sheet(isPresented: $showPrivacyPolicy) {
            PrivacyPolicyView()
        }
        .sheet(isPresented: $showCopyrightPolicy) {
            CopyrightPolicyView()
        }
        .sheet(isPresented: $showLicenses) {
            LicensesView()
        }
        .sheet(isPresented: $showAboutRecommendations) {
            AboutRecommendationsView()
        }
    }
    
    @ViewBuilder
    var buttonTermsConditions: some View {
        Button(action: {
            Logger.viewCycle.info("Button pressed Term & Conditions")
            showTermsConditions = true
        }) {
            HStack {
                Text("terms.Conditions.Title")
                    .modifier(ButtonsSettingsScreenModifier())
                Spacer()
            }
            .buttonStyle(CardButtonStyle())
        }
    }
    
    @ViewBuilder
    var buttonPrivacyPolicy: some View {
        Button(action: {
            Logger.viewCycle.info("Button pressed Privacy Policy")
            showPrivacyPolicy = true
        }) {
            HStack {
                Text("privacy.Policy.Title")
                    .modifier(ButtonsSettingsScreenModifier())
                Spacer()
            }
            .buttonStyle(CardButtonStyle())
        }
    }
    
    @ViewBuilder
    var buttonCopyrightPolicy: some View {
        Button(action: {
            Logger.viewCycle.info("Button pressed Copyright Policy")
            showCopyrightPolicy = true
        }) {
            HStack {
                Text("copyright.Policy.Title")
                    .modifier(ButtonsSettingsScreenModifier())
                Spacer()
            }
            .buttonStyle(CardButtonStyle())
        }
    }
    
    @ViewBuilder
    var buttonLicenses: some View {
        Button(action: {
            Logger.viewCycle.info("Button pressed Licenses")
            showLicenses = true
        }) {
            HStack {
                Text("licenses.Title")
                    .modifier(ButtonsSettingsScreenModifier())
                Spacer()
            }
            .buttonStyle(CardButtonStyle())
        }
    }
    
    @ViewBuilder
    var buttonAboutRecommendations: some View {
        Button(action: {
            Logger.viewCycle.info("Button pressed About Recommendations")
            showAboutRecommendations = true
        }) {
            HStack {
                Text("about.Recommendations.Title")
                    .modifier(ButtonsSettingsScreenModifier())
                Spacer()
            }
            .buttonStyle(CardButtonStyle())
        }
    }
    
    @ViewBuilder
    var buttonLogOut: some View {
        Button(action: {
            Logger.viewCycle.info("Button pressed Log Out")
            // TODO: add log out action
        }) {
            HStack {
                Text("log.Out.Title")
                    .modifier(ButtonsSettingsScreenModifier())
                Spacer()
                Text("user.name")
                    .modifier(ButtonsSettingsScreenModifier())
            }
            .buttonStyle(CardButtonStyle())
        }
    }
}

#if DEBUG
#Preview {
    SettingsScreenView()
}
#endif
