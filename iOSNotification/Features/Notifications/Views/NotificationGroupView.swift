//
//  NotificationGroupView.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import SwiftUI

// MARK: - Stacked Notification Group View
struct NotificationGroupView: View {
    let group: NotificationGroup
    let isExpanded: Bool
    let activeActionNotificationId: String?
    let onGroupTap: () -> Void
    let onNotificationTap: (String) -> Void
    let onKeep: (String) -> Void
    let onTurnOff: (String) -> Void
    
    var body: some View {
        if isExpanded {
            expandedView
        } else if group.hasMultiple {
            collapsedStackView
        } else if let notification = group.latestNotification {
            NotificationCardView(
                notification: notification,
                showActionButtons: activeActionNotificationId == notification.id,
                onTap: { onNotificationTap(notification.id) },
                onKeep: { onKeep(notification.id) },
                onTurnOff: { onTurnOff(notification.id) }
            )
        }
    }
    
    // MARK: - Collapsed Stack View
    private var collapsedStackView: some View {
        ZStack(alignment: .bottom) {
            // Background stacked cards (visual depth)
            RoundedRectangle(cornerRadius: AppTheme.Card.cornerRadius, style: .continuous)
                .fill(AppTheme.Card.stackedBackground.opacity(0.4))
                .frame(height: 70)
                .offset(y: AppTheme.Spacing.stackOffset1)
                .padding(.horizontal, AppTheme.Spacing.stackInset1)
            
            RoundedRectangle(cornerRadius: AppTheme.Card.cornerRadius, style: .continuous)
                .fill(AppTheme.Card.stackedBackground.opacity(0.6))
                .frame(height: 70)
                .offset(y: AppTheme.Spacing.stackOffset2)
                .padding(.horizontal, AppTheme.Spacing.stackInset2)
            
            // Top card — latest notification
            VStack(alignment: .leading, spacing: 0) {
                if let latest = group.latestNotification {
                    // Header
                    HStack(spacing: 8) {
                        Image(systemName: group.appIconName)
                            .font(AppFonts.appIcon)
                            .foregroundColor(AppTheme.Accent.primary)
                            .frame(width: AppTheme.Icon.appIconSize, height: AppTheme.Icon.appIconSize)
                            .background(
                                RoundedRectangle(cornerRadius: AppTheme.Icon.appIconCornerRadius, style: .continuous)
                                    .fill(AppTheme.Accent.iconBackground)
                            )
                        
                        Text(group.appName)
                            .font(AppFonts.appName)
                            .foregroundColor(AppTheme.Text.subtle)
                        
                        Spacer()
                        
                        Text(latest.timeAgoText)
                            .font(AppFonts.timestamp)
                            .foregroundColor(AppTheme.Text.subtle.opacity(0.7))
                    }
                    .padding(.horizontal, AppTheme.Spacing.cardPaddingH)
                    .padding(.top, AppTheme.Spacing.cardPaddingV)
                    
                    // Title
                    Text(latest.title)
                        .font(AppFonts.cardTitle)
                        .foregroundColor(AppTheme.Text.primary)
                        .padding(.horizontal, AppTheme.Spacing.cardPaddingH)
                        .padding(.top, 6)
                    
                    // Stack count
                    Text("\(group.additionalCount) more notifications")
                        .font(AppFonts.stackCount)
                        .foregroundColor(AppTheme.Text.subtle.opacity(0.8))
                        .padding(.horizontal, AppTheme.Spacing.cardPaddingH)
                        .padding(.top, 2)
                        .padding(.bottom, AppTheme.Spacing.cardPaddingV)
                }
            }
            .background(AppTheme.Card.background)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.Card.cornerRadius, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
        }
        .onTapGesture {
            onGroupTap()
        }
    }
    
    // MARK: - Expanded View (all notifications shown)
    private var expandedView: some View {
        VStack(spacing: 8) {
            ForEach(group.notifications) { notification in
                NotificationCardView(
                    notification: notification,
                    showActionButtons: activeActionNotificationId == notification.id,
                    onTap: { onNotificationTap(notification.id) },
                    onKeep: { onKeep(notification.id) },
                    onTurnOff: { onTurnOff(notification.id) }
                )
            }
            
            // Collapse button
            Button(action: onGroupTap) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.up")
                        .font(AppFonts.collapseIcon)
                    Text("Show less")
                        .font(AppFonts.collapseText)
                }
                .foregroundColor(AppTheme.Text.subtle)
                .padding(.vertical, 6)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        AppTheme.Background.gradient
            .ignoresSafeArea()
        
        VStack(spacing: 20) {
            let mockData = NotificationMockData.generateMockNotifications()
            let group = NotificationGroup(
                id: "1SONiA",
                appName: "1SONiA",
                appIconName: "bubble.left.fill",
                notifications: Array(mockData[0...2])
            )
            
            NotificationGroupView(
                group: group,
                isExpanded: false,
                activeActionNotificationId: nil,
                onGroupTap: {},
                onNotificationTap: { _ in },
                onKeep: { _ in },
                onTurnOff: { _ in }
            )
        }
        .padding()
    }
}
