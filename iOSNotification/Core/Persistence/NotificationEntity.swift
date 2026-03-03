//
//  NotificationEntity.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import Foundation
import SwiftData

// MARK: - SwiftData Entity (Local Database Layer)
@Model
final class NotificationEntity {
    @Attribute(.unique) var id: String
    var appName: String
    var appIconName: String
    var title: String
    var content: String
    var thumbnailName: String?
    var timestamp: Date
    var isRead: Bool
    var groupId: String?
    
    init(
        id: String,
        appName: String,
        appIconName: String,
        title: String,
        content: String,
        thumbnailName: String? = nil,
        timestamp: Date,
        isRead: Bool = false,
        groupId: String? = nil
    ) {
        self.id = id
        self.appName = appName
        self.appIconName = appIconName
        self.title = title
        self.content = content
        self.thumbnailName = thumbnailName
        self.timestamp = timestamp
        self.isRead = isRead
        self.groupId = groupId
    }
}

// MARK: - Mapping: Entity <-> DTO
extension NotificationEntity {
    
    /// Convert SwiftData entity → DTO for UI layer
    func toDTO() -> NotificationItem {
        NotificationItem(
            id: id,
            appName: appName,
            appIconName: appIconName,
            title: title,
            content: content,
            thumbnailName: thumbnailName,
            timestamp: timestamp,
            isRead: isRead,
            groupId: groupId
        )
    }
    
    /// Create SwiftData entity from DTO
    static func fromDTO(_ dto: NotificationItem) -> NotificationEntity {
        NotificationEntity(
            id: dto.id,
            appName: dto.appName,
            appIconName: dto.appIconName,
            title: dto.title,
            content: dto.content,
            thumbnailName: dto.thumbnailName,
            timestamp: dto.timestamp,
            isRead: dto.isRead,
            groupId: dto.groupId
        )
    }
}
