//
//  NotificationMockData.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import Foundation

// MARK: - Mock Data Generator (Preview & Debug only)
struct NotificationMockData {
    
    static func generateMockNotifications() -> [NotificationItem] {
        let now = Date()
        
        return [
            // 1SONiA App - Group of 3 notifications (will stack)
            NotificationItem(
                id: "notif_1",
                appName: "1SONiA",
                appIconName: "bubble.left.fill",
                title: "Xushxabar",
                content: "Assalomu Aleykum *Samandar*, *Bursa restoran*ni sizning buyurtmangizni qabul qildi!",
                thumbnailName: "restaurant_thumb",
                timestamp: now.addingTimeInterval(-1800),
                isRead: false,
                groupId: "1sonia_group"
            ),
            NotificationItem(
                id: "notif_2",
                appName: "1SONiA",
                appIconName: "bubble.left.fill",
                title: "Xushxabar",
                content: "Assalomu Aleykum restoraningizga yana bir yangi mijoz buyurtma qildi!",
                thumbnailName: "person_thumb",
                timestamp: now.addingTimeInterval(-1800),
                isRead: false,
                groupId: "1sonia_group"
            ),
            NotificationItem(
                id: "notif_3",
                appName: "1SONiA",
                appIconName: "bubble.left.fill",
                title: "Eslatma",
                content: "Assalomu alaykum *Samandar* dori ichadigan vaqtingiz bo'ldi!",
                thumbnailName: "pill_thumb",
                timestamp: now.addingTimeInterval(-1800),
                isRead: false,
                groupId: "1sonia_group"
            ),
            
            // TechNews - Group of 2
            NotificationItem(
                id: "notif_4",
                appName: "TechNews",
                appIconName: "newspaper.fill",
                title: "Breaking Update",
                content: "Apple announces new SwiftUI features at WWDC 2026. Tap to read more about the exciting changes.",
                thumbnailName: nil,
                timestamp: now.addingTimeInterval(-3600),
                isRead: false,
                groupId: "technews_group"
            ),
            NotificationItem(
                id: "notif_5",
                appName: "TechNews",
                appIconName: "newspaper.fill",
                title: "Weekly Digest",
                content: "Your personalized weekly tech digest is ready. 12 new articles waiting for you.",
                thumbnailName: nil,
                timestamp: now.addingTimeInterval(-3700),
                isRead: true,
                groupId: "technews_group"
            ),
            
            // FitTrack - Single notification
            NotificationItem(
                id: "notif_6",
                appName: "FitTrack",
                appIconName: "figure.run",
                title: "Goal Achieved! 🎉",
                content: "Congratulations! You've completed your daily step goal of 10,000 steps.",
                thumbnailName: nil,
                timestamp: now.addingTimeInterval(-7200),
                isRead: false,
                groupId: "fittrack_single"
            ),
            
            // QuickDeliver - Group of 3
            NotificationItem(
                id: "notif_7",
                appName: "QuickDeliver",
                appIconName: "shippingbox.fill",
                title: "Order Update",
                content: "Your order #4521 is out for delivery. Expected arrival in 15 minutes.",
                thumbnailName: nil,
                timestamp: now.addingTimeInterval(-900),
                isRead: false,
                groupId: "delivery_group"
            ),
            NotificationItem(
                id: "notif_8",
                appName: "QuickDeliver",
                appIconName: "shippingbox.fill",
                title: "Special Offer",
                content: "Get 20% off on your next order! Use code SAVE20. Valid until tomorrow.",
                thumbnailName: nil,
                timestamp: now.addingTimeInterval(-1200),
                isRead: true,
                groupId: "delivery_group"
            ),
            NotificationItem(
                id: "notif_9",
                appName: "QuickDeliver",
                appIconName: "shippingbox.fill",
                title: "Rate Your Experience",
                content: "How was your last delivery? Tap to leave a review and earn reward points.",
                thumbnailName: nil,
                timestamp: now.addingTimeInterval(-5400),
                isRead: true,
                groupId: "delivery_group"
            ),
        ]
    }
}
