//
//  NotificationRemoteDataSource.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import Foundation

// MARK: - Remote Data Source Protocol
protocol NotificationRemoteDataSource {
    func fetchNotifications() async throws -> [NotificationItem]
    func sendAction(_ action: NotificationAction, for notificationId: String) async throws
}

// MARK: - Remote Data Source Implementation
final class NotificationRemoteDataSourceImpl: NotificationRemoteDataSource {
    
    func fetchNotifications() async throws -> [NotificationItem] {
        // Simulate network delay — replace with real API call
        try await Task.sleep(nanoseconds: 500_000_000)
        return []
    }
    
    func sendAction(_ action: NotificationAction, for notificationId: String) async throws {
        // Simulate syncing action to server
        try await Task.sleep(nanoseconds: 300_000_000)
    }
}
