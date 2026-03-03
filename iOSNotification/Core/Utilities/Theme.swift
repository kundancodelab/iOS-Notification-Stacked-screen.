//
//  Theme.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import SwiftUI

// MARK: - App Theme (Single Source of Truth)
// ✅ Change colors HERE → entire app updates automatically
// ✅ Scales to any number of features

struct AppTheme {
    
    // MARK: - Background Gradient
    struct Background {
        static let gradientTop = Color(red: 0.35, green: 0.22, blue: 0.85)
        static let gradientBottom = Color(red: 0.28, green: 0.15, blue: 0.75)
        static let gradientDeep = Color(red: 0.25, green: 0.12, blue: 0.65)
        
        static var gradient: LinearGradient {
            LinearGradient(
                colors: [gradientTop, gradientBottom, gradientDeep],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    
    // MARK: - Card Colors
    struct Card {
        static let background = Color(red: 0.22, green: 0.15, blue: 0.45)
        static let backgroundLight = Color(red: 0.30, green: 0.22, blue: 0.55)
        static let stackedBackground = Color(red: 0.25, green: 0.18, blue: 0.50)
        static let cornerRadius: CGFloat = 16
        static let shadowColor = Color.black.opacity(0.25)
        static let shadowRadius: CGFloat = 8
    }
    
    // MARK: - Text Colors
    struct Text {
        static let primary = Color.white
        static let secondary = Color(red: 0.85, green: 0.82, blue: 0.95)
        static let subtle = Color(red: 0.70, green: 0.65, blue: 0.85)
        static let header = Color.white
    }
    
    // MARK: - Accent / Interactive
    struct Accent {
        static let primary = Color(red: 0.55, green: 0.40, blue: 0.95)
        static let iconBackground = Color.white.opacity(0.12)
        static let buttonBorder = Color.white.opacity(0.15)
        static let settingsBg = Color.white.opacity(0.1)
    }
    
    // MARK: - Icon Sizes
    struct Icon {
        static let appIconSize: CGFloat = 22
        static let appIconCornerRadius: CGFloat = 6
        static let appIconFontSize: CGFloat = 12
        static let settingsSize: CGFloat = 20
        static let settingsFrame: CGFloat = 40
        static let thumbnailSize: CGFloat = 40
    }
    
    // MARK: - Spacing
    struct Spacing {
        static let cardPaddingH: CGFloat = 14
        static let cardPaddingV: CGFloat = 12
        static let listPaddingH: CGFloat = 16
        static let headerPaddingH: CGFloat = 20
        static let cardGap: CGFloat = 12
        static let buttonGap: CGFloat = 12
        static let stackOffset1: CGFloat = 12
        static let stackOffset2: CGFloat = 6
        static let stackInset1: CGFloat = 16
        static let stackInset2: CGFloat = 8
    }
    
    // MARK: - Animation Presets
    struct Anim {
        static let expandSpring = SwiftUI.Animation.spring(response: 0.35, dampingFraction: 0.8)
        static let actionSpring = SwiftUI.Animation.spring(response: 0.3, dampingFraction: 0.85)
        static let dismissEase = SwiftUI.Animation.easeOut(duration: 0.25)
        static let turnOffEase = SwiftUI.Animation.easeOut(duration: 0.3)
    }
}
