//
//  AppText.swift
//
//
//  Created by Filip Štěpánek on 28.06.2024.
//

import SwiftUI

struct LogoModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.logo)
            .foregroundColor(.mainText)
    }
}

struct HeadlineModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.mainText)
    }
}

struct SoundtrackModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.soundtrackName)
            .foregroundColor(.mainText)
    }
}

struct ArtistModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.artistName)
            .foregroundColor(.mainText)
    }
}

struct HadlineLoginScreenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.loginHeadline)
            .foregroundColor(.mainText)
    }
}

struct TextLoginScreenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.loginText)
            .foregroundColor(.mainText)
    }
}

struct ButtonLoginScreenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(.purple)
            .opacity(0.6)
    }
}

struct ButtonsSettingsScreenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.settingsText)
            .foregroundColor(.mainText)
    }
}

struct SettingsHeadlineModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.settingsHeadline)
            .foregroundColor(.mainText)
    }
}

struct SettingsTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.settingsTextDesription)
            .foregroundColor(.mainText)
    }
}
