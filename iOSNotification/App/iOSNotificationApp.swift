//
//  iOSNotificationApp.swift
//  iOSNotification
//
//  Created by ibarts on 03/03/26.
//

import SwiftUI
import SwiftData

@main
struct iOSNotificationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: NotificationEntity.self)
    }
}
