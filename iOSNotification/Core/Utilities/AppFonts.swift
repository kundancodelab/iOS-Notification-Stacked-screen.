//
//  AppFonts.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import SwiftUI

// MARK: - App Fonts (Single Source of Truth)
// ✅ Change font family/sizes HERE → entire app updates
// ✅ Ready for custom fonts — just swap .system() with .custom()

struct AppFonts {
    
    // MARK: - Font Family
    // To use custom font: replace .system with .custom("YourFont-Weight", size:)
    // Example: static func custom(_ size: CGFloat, weight: Font.Weight) -> Font {
    //     .custom("Inter-\(weight)", size: size)
    // }
    
    // MARK: - Headers
    static let screenTitle = Font.system(size: 28, weight: .bold)
    static let sectionTitle = Font.system(size: 20, weight: .semibold)
    
    // MARK: - Notification Card
    static let cardTitle = Font.system(size: 15, weight: .bold)
    static let cardContent = Font.system(size: 13, weight: .regular)
    static let appName = Font.system(size: 13, weight: .medium)
    static let timestamp = Font.system(size: 12, weight: .regular)
    static let stackCount = Font.system(size: 12, weight: .medium)
    
    // MARK: - Buttons
    static let actionButton = Font.system(size: 14, weight: .semibold)
    static let actionPrompt = Font.system(size: 13, weight: .regular)
    
    // MARK: - App Icon (inside notification card)
    static let appIcon = Font.system(size: 12, weight: .semibold)
    
    // MARK: - Badges & Labels
    static let badge = Font.system(size: 11, weight: .bold)
    static let caption = Font.system(size: 12, weight: .regular)
    static let subtitle = Font.system(size: 14, weight: .medium)
    
    // MARK: - Empty State
    static let emptyTitle = Font.system(size: 20, weight: .semibold)
    static let emptySubtitle = Font.system(size: 14, weight: .regular)
    
    // MARK: - Collapse Button
    static let collapseIcon = Font.system(size: 11, weight: .bold)
    static let collapseText = Font.system(size: 12, weight: .semibold)
    
    // MARK: - Thumbnail
    static let thumbnailLetter = Font.system(size: 18, weight: .bold, design: .serif)
    static let thumbnailIcon = Font.system(size: 18)
    static let thumbnailEmoji = Font.system(size: 20)
}
