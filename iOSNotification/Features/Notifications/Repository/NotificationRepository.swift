//
//  NotificationRepository.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import Foundation

// MARK: - Notification Repository Protocol
protocol NotificationRepository {
    func fetchNotifications() async throws -> [NotificationItem]
    func getGroupedNotifications() async throws -> [NotificationGroup]
    func markAsRead(notificationId: String) async throws
    func performAction(_ action: NotificationAction, for notificationId: String) async throws
    func performAction(_ action: NotificationAction, for groupId: String, appName: String) async throws
}
