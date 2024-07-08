//
//  tabBarTest2.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 27.06.2024.
//

import SwiftUI

struct tabBarView: View {
    var body: some View {
        ZStack{
            
            BackgroundGradientView()
            
            NavigationView{
                TabView {
                    HomeScreenView()
                        .tabItem {
                            Label("home.TabBar.Titlee", systemImage: "")
                        }
                    YourLibraryView()
                        .tabItem {
                            Label("your.Library.TabBar.Title", systemImage: "")
                        }
                    SearchScreenView()
                        .tabItem {
                            Label("search.TabBar.Title", systemImage: "")
                        }
                    SettingsScreenView()
                        .tabItem {
                            Label("settings.TabBar.Title", systemImage: "")
                        }
                }
                .accentColor(.white)
            }
        }
    }
}


