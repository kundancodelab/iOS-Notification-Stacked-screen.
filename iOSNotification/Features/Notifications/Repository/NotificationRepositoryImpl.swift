//
//  NotificationRepositoryImpl.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import Foundation
import SwiftData

// MARK: - Repository Implementation (Offline-First)
@MainActor
final class NotificationRepositoryImpl: NotificationRepository {
    
    private let localDataSource: NotificationLocalDataSource
    private let remoteDataSource: NotificationRemoteDataSource
    
    init(
        localDataSource: NotificationLocalDataSource? = nil,
        remoteDataSource: NotificationRemoteDataSource = NotificationRemoteDataSourceImpl(),
        modelContext: ModelContext? = nil
    ) {
        if let localDS = localDataSource {
            self.localDataSource = localDS
        } else if let context = modelContext {
            self.localDataSource = NotificationLocalDataSourceImpl(modelContext: context)
        } else {
            fatalError("NotificationRepositoryImpl requires a ModelContext or a LocalDataSource")
        }
        self.remoteDataSource = remoteDataSource
    }
    
    // MARK: - Offline-First: Local first, then sync from remote
    func fetchNotifications() async throws -> [NotificationItem] {
        let localNotifications = try localDataSource.getNotifications()
        
        if !localNotifications.isEmpty {
            return localNotifications
        }
        
        // Seed with mock data for demo
        let mockData = NotificationMockData.generateMockNotifications()
        try localDataSource.saveNotifications(mockData)
        return mockData
    }
    
    func getGroupedNotifications() async throws -> [NotificationGroup] {
        let notifications = try await fetchNotifications()
        return groupNotifications(notifications)
    }
    
    func markAsRead(notificationId: String) async throws {
        try localDataSource.markAsRead(notificationId: notificationId)
        
        Task.detached { [remoteDataSource] in
            try? await remoteDataSource.sendAction(.keep, for: notificationId)
        }
    }
    
    func performAction(_ action: NotificationAction, for notificationId: String) async throws {
        switch action {
        case .keep:
            try localDataSource.markAsRead(notificationId: notificationId)
        case .turnOff:
            try localDataSource.removeNotification(notificationId: notificationId)
        }
        
        Task.detached { [remoteDataSource] in
            try? await remoteDataSource.sendAction(action, for: notificationId)
        }
    }
    
    func performAction(_ action: NotificationAction, for groupId: String, appName: String) async throws {
        switch action {
        case .keep:
            break
        case .turnOff:
            try localDataSource.removeNotificationsForApp(appName: appName)
        }
    }
    
    // MARK: - Group notifications by appName
    private func groupNotifications(_ notifications: [NotificationItem]) -> [NotificationGroup] {
        let grouped = Dictionary(grouping: notifications) { $0.appName }
        
        return grouped.map { appName, items in
            let sortedItems = items.sorted { $0.timestamp > $1.timestamp }
            return NotificationGroup(
                id: appName,
                appName: appName,
                appIconName: sortedItems.first?.appIconName ?? "app.fill",
                notifications: sortedItems
            )
        }
        .sorted { ($0.latestNotification?.timestamp ?? .distantPast) > ($1.latestNotification?.timestamp ?? .distantPast) }
    }
}
