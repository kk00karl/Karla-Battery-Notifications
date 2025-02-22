//
//  KarlaApp.swift
//  Karla
//
//  Created by k k on 2025/1/5.
//

import SwiftUI

@main
struct KarlaApp: App {
    @StateObject private var batteryManager = BatteryManager()
    @StateObject private var settings = BatteryAlertSettings()
    
    init() {
        // 确保通知管理器被初始化
        _ = NotificationManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(batteryManager)
                .environmentObject(settings)
                .frame(minWidth: 300, maxWidth: 400)
                .frame(minHeight: 400, maxHeight: 500)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}
