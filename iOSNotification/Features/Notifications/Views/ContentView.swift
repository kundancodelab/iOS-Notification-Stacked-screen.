//
//  ContentView.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import SwiftUI
import SwiftData

// MARK: - Entry Point (passes ModelContext to the notification screen)
struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NotificationScreen(viewModel: NotificationViewModel(modelContext: modelContext))
    }
}

// MARK: - Main Notification Screen
struct NotificationScreen: View {
    
    @ObservedObject var viewModel: NotificationViewModel
    
    var body: some View {
        ZStack {
            // Full-screen purple gradient background
            AppTheme.Background.gradient
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Navigation Header
                headerView
                
                // Notification List
                if viewModel.isLoading {
                    loadingView
                } else if viewModel.notificationGroups.isEmpty {
                    emptyStateView
                } else {
                    notificationListView
                }
            }
        }
        .task {
            await viewModel.loadNotifications()
        }
    }
    
    // MARK: - Header
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Notifications")
                    .font(AppFonts.screenTitle)
                    .foregroundColor(AppTheme.Text.header)
                
                Text(notificationCountText)
                    .font(AppFonts.subtitle)
                    .foregroundColor(AppTheme.Text.subtle)
            }
            
            Spacer()
            
            // Settings button
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: AppTheme.Icon.settingsSize))
                    .foregroundColor(AppTheme.Text.subtle)
                    .frame(width: AppTheme.Icon.settingsFrame, height: AppTheme.Icon.settingsFrame)
                    .background(
                        Circle()
                            .fill(AppTheme.Accent.settingsBg)
                    )
            }
        }
        .padding(.horizontal, AppTheme.Spacing.headerPaddingH)
        .padding(.top, 8)
        .padding(.bottom, 16)
    }
    
    // MARK: - Notification Count Text
    private var notificationCountText: String {
        let totalCount = viewModel.notificationGroups.reduce(0) { $0 + $1.notifications.count }
        let unreadCount = viewModel.notificationGroups.reduce(0) { sum, group in
            sum + group.notifications.filter { !$0.isRead }.count
        }
        if unreadCount == 0 {
            return "\(totalCount) notifications"
        }
        return "\(unreadCount) unread · \(totalCount) total"
    }
    
    // MARK: - Notification List
    private var notificationListView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: AppTheme.Spacing.cardGap) {
                ForEach(viewModel.notificationGroups) { group in
                    NotificationGroupView(
                        group: group,
                        isExpanded: viewModel.isGroupExpanded(group.id),
                        activeActionNotificationId: viewModel.activeActionNotificationId,
                        onGroupTap: {
                            viewModel.toggleGroupExpansion(group.id)
                        },
                        onNotificationTap: { notificationId in
                            viewModel.toggleActionButtons(for: notificationId)
                        },
                        onKeep: { notificationId in
                            Task {
                                await viewModel.keepNotification(notificationId)
                            }
                        },
                        onTurnOff: { notificationId in
                            Task {
                                await viewModel.turnOffNotification(notificationId)
                            }
                        }
                    )
                    .transition(.asymmetric(
                        insertion: .move(edge: .top).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity)
                    ))
                }
            }
            .padding(.horizontal, AppTheme.Spacing.listPaddingH)
            .padding(.bottom, 30)
        }
    }
    
    // MARK: - Loading State
    private var loadingView: some View {
        VStack(spacing: 16) {
            Spacer()
            
            VStack(spacing: 12) {
                ForEach(0..<3, id: \.self) { index in
                    ShimmerCardView()
                        .opacity(1.0 - Double(index) * 0.15)
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
        }
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(systemName: "bell.slash.fill")
                .font(.system(size: 50))
                .foregroundColor(AppTheme.Text.subtle.opacity(0.5))
            
            Text("No Notifications")
                .font(AppFonts.emptyTitle)
                .foregroundColor(AppTheme.Text.header)
            
            Text("You're all caught up! Check back later.")
                .font(AppFonts.emptySubtitle)
                .foregroundColor(AppTheme.Text.subtle)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
}

// MARK: - Shimmer Loading Card
struct ShimmerCardView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(shimmerGradient)
                    .frame(width: 22, height: 22)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(shimmerGradient)
                    .frame(width: 80, height: 14)
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(shimmerGradient)
                    .frame(width: 50, height: 12)
            }
            
            RoundedRectangle(cornerRadius: 4)
                .fill(shimmerGradient)
                .frame(width: 120, height: 16)
            
            RoundedRectangle(cornerRadius: 4)
                .fill(shimmerGradient)
                .frame(height: 13)
            
            RoundedRectangle(cornerRadius: 4)
                .fill(shimmerGradient)
                .frame(width: 200, height: 13)
        }
        .padding(AppTheme.Spacing.cardPaddingH)
        .background(AppTheme.Card.background)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.Card.cornerRadius, style: .continuous))
        .onAppear {
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
    
    private var shimmerGradient: some ShapeStyle {
        Color.white.opacity(isAnimating ? 0.15 : 0.06)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
        .modelContainer(for: NotificationEntity.self, inMemory: true)
}
