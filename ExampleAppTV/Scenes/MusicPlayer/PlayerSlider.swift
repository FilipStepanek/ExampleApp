//
//  PlayerSlider.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 20.06.2024.
//


import SwiftUI

struct PlayerSlider: View {
    @Binding public var value: Double
    var range: ClosedRange<Double> = 0...1
    var knobColor: Color = .white
    var trackColor: Color = Color.gray.opacity(0.3)
    var seekCallback: (Double) -> Void // Callback to seek audio
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 4)
                    .foregroundColor(self.trackColor)
                    .cornerRadius(2)
                
                Rectangle()
                    .frame(width: CGFloat(self.normalizedValue(from: self.value, in: self.range)) * geometry.size.width, height: 4)
                    .foregroundColor(self.knobColor)
                    .cornerRadius(2)
                    .animation(.easeInOut, value: value)               
            }
        }
    }
    
    func normalizedValue(from value: Double, in range: ClosedRange<Double>) -> Double {
        return (value - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
    
    func interpolatedValue(from normalizedValue: Double, in range: ClosedRange<Double>) -> Double {
        return range.lowerBound + normalizedValue * (range.upperBound - range.lowerBound)
    }
    
    func clamp(_ value: Double, in range: ClosedRange<Double>) -> Double {
        return min(max(value, range.lowerBound), range.upperBound)
    }
}
