//
//  ButtonStyle.swift
//  ExampleAppTV
//
//  Created by Filip Štěpánek on 01.07.2024.
//

import SwiftUI

struct NewButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct FocusableButton<Label: View>: View {
    let action: () -> Void
    let label: () -> Label
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        Button(action: action) {
            label()
                .scaleEffect(isFocused ? 1.05 : 1.0) // Scale effect when focused
                .animation(.easeInOut(duration: 0.2), value: isFocused) // Smooth transition
        }
        .buttonStyle(NewButtonStyle())
        .focused($isFocused)
    }
}

struct LoginButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 20)
            .padding(.horizontal, 50)
            .background(configuration.isPressed ? .red : .black)
            .foregroundStyle(.thinMaterial)
            .clipShape(Capsule())
            .buttonStyle(CardButtonStyle())
    }
}


struct LoginCardButtonStyle: ButtonStyle {
    var backgroundColor: Color = Color.white.opacity(0.8)
    var pressedColor: Color = Color.white.opacity(0.4)
    var cornerRadius: CGFloat = 10
    var shadowColor: Color = Color.black.opacity(0.1)
    var shadowRadius: CGFloat = 20
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 20)
            .padding(.horizontal, 50)
            .background(configuration.isPressed ? pressedColor : backgroundColor)
            .shadow(color: shadowColor, radius: shadowRadius)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .hoverEffect()
            .animation(.spring(), value: configuration.isPressed)
    }
}

struct SettingButtonStyle: ButtonStyle {
    var backgroundColor: Color = Color.white.opacity(0.8)
    var pressedColor: Color = Color.white.opacity(0.4)
    var cornerRadius: CGFloat = 10
    var shadowColor: Color = Color.black.opacity(0.1)
    var shadowRadius: CGFloat = 20
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 20)
            .frame(width: 300)
            .padding(.trailing, 25)
            .padding(.leading, 25)
            .background(configuration.isPressed ? pressedColor : backgroundColor)
            .shadow(color: shadowColor, radius: shadowRadius)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .hoverEffect()
            .animation(.spring(), value: configuration.isPressed)
    }
}
