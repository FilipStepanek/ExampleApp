//
//  test.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 26.06.2024.
//

import SwiftUI
import Shared

struct test: View {
    @ObservedObject var viewModel = SoundsViewModel()

       var body: some View {
           NavigationView {
               List(viewModel.soundsItems) { item in
                   HStack {
                       VStack(alignment: .leading) {
                           Text(item.title)
                               .font(.headline)
                           Text(item.artist)
                               .font(.subheadline)
                           Text(item.category)
                               .font(.subheadline)
                       }
                   }
               }
               .navigationTitle("Sounds Items")
               .onAppear {
                   print("View Appeared, items count: \(viewModel.soundsItems.count)") // Debugging line
               }
           }
       }
   }

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
