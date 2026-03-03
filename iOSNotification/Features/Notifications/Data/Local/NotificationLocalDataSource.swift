//
//  NotificationLocalDataSource.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import Foundation
import SwiftData

// MARK: - Local Data Source Protocol
protocol NotificationLocalDataSource {
    func getNotifications() throws -> [NotificationItem]
    func saveNotifications(_ notifications: [NotificationItem]) throws
    func markAsRead(notificationId: String) throws
    func removeNotification(notificationId: String) throws
    func removeNotificationsForApp(appName: String) throws
}

// MARK: - SwiftData Local Data Source Implementation
@MainActor
final class NotificationLocalDataSourceImpl: NotificationLocalDataSource {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getNotifications() throws -> [NotificationItem] {
        let descriptor = FetchDescriptor<NotificationEntity>(
            sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
        )
        let entities = try modelContext.fetch(descriptor)
        return entities.map { $0.toDTO() }
    }
    
    func saveNotifications(_ notifications: [NotificationItem]) throws {
        for dto in notifications {
            let id = dto.id
            let descriptor = FetchDescriptor<NotificationEntity>(
                predicate: #Predicate { $0.id == id }
            )
            let existing = try modelContext.fetch(descriptor)
            
            if existing.isEmpty {
                let entity = NotificationEntity.fromDTO(dto)
                modelContext.insert(entity)
            }
        }
        try modelContext.save()
    }
    
    func markAsRead(notificationId: String) throws {
        let descriptor = FetchDescriptor<NotificationEntity>(
            predicate: #Predicate { $0.id == notificationId }
        )
        let results = try modelContext.fetch(descriptor)
        
        if let entity = results.first {
            entity.isRead = true
            try modelContext.save()
        }
    }
    
    func removeNotification(notificationId: String) throws {
        let descriptor = FetchDescriptor<NotificationEntity>(
            predicate: #Predicate { $0.id == notificationId }
        )
        let results = try modelContext.fetch(descriptor)
        
        for entity in results {
            modelContext.delete(entity)
        }
        try modelContext.save()
    }
    
    func removeNotificationsForApp(appName: String) throws {
        let descriptor = FetchDescriptor<NotificationEntity>(
            predicate: #Predicate { $0.appName == appName }
        )
        let results = try modelContext.fetch(descriptor)
        
        for entity in results {
            modelContext.delete(entity)
        }
        try modelContext.save()
    }
}
