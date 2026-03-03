//
//  NotificationCardView.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import SwiftUI

// MARK: - Single Notification Card
struct NotificationCardView: View {
    let notification: NotificationItem
    let showActionButtons: Bool
    let onTap: () -> Void
    let onKeep: () -> Void
    let onTurnOff: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Main card content
            cardContent
            
            // Action buttons (Keep / Turn Off) — shown on tap
            if showActionButtons {
                actionSection
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .background(AppTheme.Card.background)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.Card.cornerRadius, style: .continuous))
        .shadow(color: AppTheme.Card.shadowColor, radius: AppTheme.Card.shadowRadius, x: 0, y: 4)
        .onTapGesture {
            onTap()
        }
    }
    
    // MARK: - Card Content
    private var cardContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header: App icon + App name + Time
            HStack(spacing: 8) {
                // App Icon
                Image(systemName: notification.appIconName)
                    .font(AppFonts.appIcon)
                    .foregroundColor(AppTheme.Accent.primary)
                    .frame(width: AppTheme.Icon.appIconSize, height: AppTheme.Icon.appIconSize)
                    .background(
                        RoundedRectangle(cornerRadius: AppTheme.Icon.appIconCornerRadius, style: .continuous)
                            .fill(AppTheme.Accent.iconBackground)
                    )
                
                Text(notification.appName)
                    .font(AppFonts.appName)
                    .foregroundColor(AppTheme.Text.subtle)
                
                Spacer()
                
                Text(notification.timeAgoText)
                    .font(AppFonts.timestamp)
                    .foregroundColor(AppTheme.Text.subtle.opacity(0.7))
            }
            
            // Title + Thumbnail Row
            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    // Title
                    Text(notification.title)
                        .font(AppFonts.cardTitle)
                        .foregroundColor(AppTheme.Text.primary)
                    
                    // Content
                    Text(notification.content)
                        .font(AppFonts.cardContent)
                        .foregroundColor(AppTheme.Text.secondary)
                        .lineLimit(showActionButtons ? nil : 2)
                        .fixedSize(horizontal: false, vertical: showActionButtons)
                }
                
                Spacer(minLength: 0)
                
                // Thumbnail (if available)
                if let thumbName = notification.thumbnailName {
                    thumbnailView(thumbName)
                }
            }
        }
        .padding(.horizontal, AppTheme.Spacing.cardPaddingH)
        .padding(.vertical, AppTheme.Spacing.cardPaddingV)
    }
    
    // MARK: - Thumbnail
    private func thumbnailView(_ name: String) -> some View {
        Group {
            switch name {
            case "restaurant_thumb":
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.13, green: 0.40, blue: 0.30), Color(red: 0.20, green: 0.55, blue: 0.40)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: AppTheme.Icon.thumbnailSize, height: AppTheme.Icon.thumbnailSize)
                    .overlay(
                        Text("V")
                            .font(AppFonts.thumbnailLetter)
                            .foregroundColor(Color(red: 0.85, green: 0.70, blue: 0.30))
                    )
                    .overlay(
                        Circle()
                            .stroke(Color(red: 0.85, green: 0.70, blue: 0.30), lineWidth: 1.5)
                    )
            case "person_thumb":
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.orange.opacity(0.7), Color.brown.opacity(0.6)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: AppTheme.Icon.thumbnailSize, height: AppTheme.Icon.thumbnailSize)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(AppFonts.thumbnailIcon)
                            .foregroundColor(.white)
                    )
            case "pill_thumb":
                Circle()
                    .fill(Color(red: 0.85, green: 0.92, blue: 1.0))
                    .frame(width: AppTheme.Icon.thumbnailSize, height: AppTheme.Icon.thumbnailSize)
                    .overlay(
                        Text("💊")
                            .font(AppFonts.thumbnailEmoji)
                    )
            default:
                EmptyView()
            }
        }
    }
    
    // MARK: - Action Section (Keep / Turn Off)
    private var actionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Divider()
                .background(Color.white.opacity(0.1))
            
            Text("Keep receiving notifications from the **\(notification.appName)** app?")
                .font(AppFonts.actionPrompt)
                .foregroundColor(AppTheme.Text.secondary)
                .padding(.horizontal, AppTheme.Spacing.cardPaddingH)
            
            HStack(spacing: AppTheme.Spacing.buttonGap) {
                // Keep Button
                Button(action: onKeep) {
                    Text("Keep...")
                        .font(AppFonts.actionButton)
                        .foregroundColor(AppTheme.Text.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(AppTheme.Card.backgroundLight)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .stroke(AppTheme.Accent.buttonBorder, lineWidth: 1)
                                )
                        )
                }
                
                // Turn Off Button
                Button(action: onTurnOff) {
                    Text("Turn off...")
                        .font(AppFonts.actionButton)
                        .foregroundColor(AppTheme.Text.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(AppTheme.Card.backgroundLight)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .stroke(AppTheme.Accent.buttonBorder, lineWidth: 1)
                                )
                        )
                }
            }
            .padding(.horizontal, AppTheme.Spacing.cardPaddingH)
            .padding(.bottom, AppTheme.Spacing.cardPaddingV)
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        AppTheme.Background.gradientTop
            .ignoresSafeArea()
        
        VStack(spacing: AppTheme.Spacing.cardGap) {
            NotificationCardView(
                notification: NotificationMockData.generateMockNotifications()[0],
                showActionButtons: false,
                onTap: {},
                onKeep: {},
                onTurnOff: {}
            )
            
            NotificationCardView(
                notification: NotificationMockData.generateMockNotifications()[0],
                showActionButtons: true,
                onTap: {},
                onKeep: {},
                onTurnOff: {}
            )
        }
        .padding()
    }
}
