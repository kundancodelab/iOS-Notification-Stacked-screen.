//
//  NotificationViewModel.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import Foundation
import SwiftUI
import SwiftData
import Combine

// MARK: - Notification ViewModel
@MainActor
final class NotificationViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var notificationGroups: [NotificationGroup] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var expandedGroupId: String?
    @Published var activeActionNotificationId: String?
    
    // MARK: - Dependencies
    private let repository: NotificationRepository
    
    // MARK: - Init
    init(modelContext: ModelContext) {
        self.repository = NotificationRepositoryImpl(modelContext: modelContext)
    }
    
    // MARK: - Fetch Notifications
    func loadNotifications() async {
        isLoading = true
        errorMessage = nil
        
        do {
            notificationGroups = try await repository.getGroupedNotifications()
        } catch {
            errorMessage = "Failed to load notifications"
        }
        
        isLoading = false
    }
    
    // MARK: - Toggle group expand/collapse (stacked notifications)
    func toggleGroupExpansion(_ groupId: String) {
        withAnimation(AppTheme.Anim.expandSpring) {
            if expandedGroupId == groupId {
                expandedGroupId = nil
            } else {
                expandedGroupId = groupId
            }
        }
    }
    
    // MARK: - Show action buttons (Keep / Turn Off)
    func toggleActionButtons(for notificationId: String) {
        withAnimation(AppTheme.Anim.actionSpring) {
            if activeActionNotificationId == notificationId {
                activeActionNotificationId = nil
            } else {
                activeActionNotificationId = notificationId
            }
        }
    }
    
    // MARK: - Perform Keep action
    func keepNotification(_ notificationId: String) async {
        do {
            try await repository.performAction(.keep, for: notificationId)
            withAnimation(AppTheme.Anim.dismissEase) {
                activeActionNotificationId = nil
            }
            await loadNotifications()
        } catch {
            errorMessage = "Action failed"
        }
    }
    
    // MARK: - Perform Turn Off action
    func turnOffNotification(_ notificationId: String) async {
        do {
            try await repository.performAction(.turnOff, for: notificationId)
            withAnimation(AppTheme.Anim.turnOffEase) {
                activeActionNotificationId = nil
            }
            await loadNotifications()
        } catch {
            errorMessage = "Action failed"
        }
    }
    
    // MARK: - Keep all for a group
    func keepGroup(_ group: NotificationGroup) async {
        for notification in group.notifications {
            try? await repository.performAction(.keep, for: notification.id)
        }
        withAnimation { activeActionNotificationId = nil }
        await loadNotifications()
    }
    
    // MARK: - Turn off all for a group
    func turnOffGroup(_ group: NotificationGroup) async {
        try? await repository.performAction(.turnOff, for: group.id, appName: group.appName)
        withAnimation { activeActionNotificationId = nil }
        await loadNotifications()
    }
    
    // MARK: - Check if group is expanded
    func isGroupExpanded(_ groupId: String) -> Bool {
        expandedGroupId == groupId
    }
    
    // MARK: - Check if action buttons visible
    func isActionActive(for notificationId: String) -> Bool {
        activeActionNotificationId == notificationId
    }
}
