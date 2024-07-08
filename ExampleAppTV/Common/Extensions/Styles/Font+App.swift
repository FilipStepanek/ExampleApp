//
//  File.swift
//  
//
//  Created by Filip Štěpánek on 28.06.2024.
//

import SwiftUI

extension Font {
    private static let majorMonoDisplayRegular = "MajorMonoDisplay-Regular"
    private static let interBold = "Inter-Bold"
    private static let interMedium = "Inter-Medium"
    private static let interRegular = "Inter-Regular"
    private static let interSemibold = "Inter-SemiBold"
    
    enum FontSize: CGFloat {
        case logoSize = 150
        case headlineSize = 50
        case soundtrack = 30
        case artist = 25
        case loginHeadline = 60
        case settingsHeadline = 80
        case loginText = 35
        case settingsText = 45
    }
    
    // Logo - name
    static let logo = (custom(Self.majorMonoDisplayRegular, size: Self.FontSize.logoSize.rawValue))
    
    // Headline
    static let headline = (custom(Self.interSemibold, size: Self.FontSize.headlineSize.rawValue))
    
    // SoundtrackName
    static let soundtrackName = (custom(Self.interRegular, size: Self.FontSize.soundtrack.rawValue))
    
    // ArtistName
    static let artistName = (custom(Self.interRegular, size: Self.FontSize.artist.rawValue))
    
    // LoginScreenHeadline
    static let loginHeadline = (custom(Self.interMedium, size: Self.FontSize.loginHeadline.rawValue))
    
    // LoginScreenText
    static let loginText = (custom(Self.interMedium, size: Self.FontSize.loginText.rawValue))
    
    // LoginScreenText
    static let settingsText = (custom(Self.interMedium, size: Self.FontSize.settingsText.rawValue))
    
    // SettingsHeadline
    static let settingsHeadline = (custom(Self.interBold, size: Self.FontSize.settingsHeadline.rawValue))
    
    // SettingsText
    static let settingsTextDesription = (custom(Self.interMedium, size: Self.FontSize.settingsText.rawValue))
    
}
