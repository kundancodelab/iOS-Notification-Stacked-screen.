//
//  NotificationDTOs.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import Foundation

// MARK: - Notification Item Model
struct NotificationItem: Identifiable, Codable, Equatable {
    let id: String
    let appName: String
    let appIconName: String
    let title: String
    let content: String
    let thumbnailName: String?
    let timestamp: Date
    let isRead: Bool
    let groupId: String?
    
    var timeAgoText: String {
        let interval = Date().timeIntervalSince(timestamp)
        let minutes = Int(interval / 60)
        let hours = Int(interval / 3600)
        let days = Int(interval / 86400)
        
        if minutes < 1 { return "Just now" }
        if minutes < 60 { return "\(minutes)m ago" }
        if hours < 24 { return "\(hours)h ago" }
        return "\(days)d ago"
    }
}

// MARK: - Notification Group (for stacked notifications)
struct NotificationGroup: Identifiable, Equatable {
    let id: String
    let appName: String
    let appIconName: String
    let notifications: [NotificationItem]
    
    var latestNotification: NotificationItem? {
        notifications.first
    }
    
    var additionalCount: Int {
        max(0, notifications.count - 1)
    }
    
    var hasMultiple: Bool {
        notifications.count > 1
    }
}

// MARK: - Notification Action
enum NotificationAction: String, Codable {
    case keep
    case turnOff
}

// MARK: - API Response DTO
struct NotificationResponseDTO: Codable {
    let notifications: [NotificationItem]
    let totalCount: Int
    let page: Int
}
