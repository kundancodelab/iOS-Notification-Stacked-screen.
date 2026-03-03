//
//  Extensions.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import Foundation
import SwiftUI

// MARK: - Date Extensions
extension Date {
    var timeAgoDisplay: String {
        let interval = Date().timeIntervalSince(self)
        let minutes = Int(interval / 60)
        let hours = Int(interval / 3600)
        let days = Int(interval / 86400)
        
        if minutes < 1 { return "Just now" }
        if minutes < 60 { return "\(minutes)m ago" }
        if hours < 24 { return "\(hours)h ago" }
        if days < 7 { return "\(days)d ago" }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
}

// MARK: - View Extensions
extension View {
    func cardStyle(
        backgroundColor: Color = AppTheme.Card.background,
        cornerRadius: CGFloat = AppTheme.Card.cornerRadius
    ) -> some View {
        self
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: AppTheme.Card.shadowColor, radius: AppTheme.Card.shadowRadius, x: 0, y: 4)
    }
}
