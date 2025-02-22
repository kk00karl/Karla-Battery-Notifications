//
//  ContentView.swift
//  Karla
//
//  Created by k k on 2025/1/5.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var batteryManager: BatteryManager
    @EnvironmentObject var settings: BatteryAlertSettings
    @State private var threshold: Double = 50
    
    var body: some View {
        VStack(spacing: 20) {
            // 电池状态显示区域
            BatteryStatusView(batteryManager: batteryManager)
            
            // 电量提醒设置区域
            BatteryAlertView(settings: settings, threshold: $threshold)
            
            // 开发者信息
            Text("Developer: Kk")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 8)
        }
        .padding(20)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

// 电池状态显示视图
struct BatteryStatusView: View {
    @ObservedObject var batteryManager: BatteryManager
    @State private var showTestControls = false
    @State private var testLevel: Double = 0.5
    
    var body: some View {
        VStack(spacing: 16) {
            // 原有的电池状态显示
            HStack(spacing: 15) {
                Image(systemName: batteryManager.isCharging ? "battery.100.bolt" : "battery.100")
                    .font(.system(size: 60))
                    .foregroundColor(batteryColor)
                    // 双击显示测试控制器
                    .onTapGesture(count: 2) {
                        batteryManager.isTestMode.toggle()
                        showTestControls.toggle()
                    }
                
                VStack(alignment: .leading) {
                    Text("\(Int(batteryManager.batteryLevel * 100))%")
                        .font(.system(size: 40, weight: .medium))
                    Text(batteryManager.isCharging ? "正在充电" : "使用电池中")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(12)
            
            // 测试控制面板
            if showTestControls {
                VStack(spacing: 10) {
                    Text("测试模式")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    HStack {
                        Text("电量: \(Int(testLevel * 100))%")
                        Slider(value: $testLevel, in: 0...1)
                    }
                    
                    HStack {
                        Toggle("充电状态", isOn: .init(
                            get: { batteryManager.isCharging },
                            set: { newValue in
                                batteryManager.setTestValues(
                                    level: testLevel,
                                    charging: newValue
                                )
                            }
                        ))
                        
                        Button("应用测试值") {
                            batteryManager.setTestValues(
                                level: testLevel,
                                charging: batteryManager.isCharging
                            )
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor))
                .cornerRadius(8)
                .transition(.slide)
            }
        }
    }
    
    var batteryColor: Color {
        let level = batteryManager.batteryLevel
        if batteryManager.isCharging { return .green }
        if level <= 0.2 { return .red }
        if level <= 0.5 { return .yellow }
        return .green
    }
}

// 电量提醒设置视图
struct BatteryAlertView: View {
    @ObservedObject var settings: BatteryAlertSettings
    @Binding var threshold: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("电量提醒设置")
                .font(.headline)
            
            // 滑动条设置区域
            VStack(alignment: .leading, spacing: 8) {
                Text("新增提醒阈值: \(Int(threshold))%")
                    .font(.subheadline)
                
                HStack {
                    Text("0%")
                    Slider(value: $threshold, in: 1...100, step: 1)
                    Text("100%")
                }
                
                Button(action: addAlert) {
                    Text("添加提醒")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 8)
            }
            
            // 现有提醒列表
            VStack(alignment: .leading, spacing: 8) {
                Text("已设置的提醒")
                    .font(.headline)
                
                List {
                    ForEach($settings.alerts) { $alert in
                        HStack {
                            Toggle("", isOn: $alert.isEnabled)
                                .labelsHidden()
                            Text("\(alert.threshold)%")
                                .frame(width: 40)
                            Spacer()
                            Button(action: { deleteAlert(alert) }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(.plain)
                .frame(height: min(CGFloat(settings.alerts.count * 30 + 10), 150))
            }
        }
        .padding()
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(12)
    }
    
    private func addAlert() {
        settings.alerts.append(BatteryAlert(
            threshold: Int(threshold),
            isEnabled: true,
            message: "电池电量达到\(Int(threshold))%"
        ))
    }
    
    private func deleteAlert(_ alert: BatteryAlert) {
        settings.alerts.removeAll { $0.id == alert.id }
    }
}

#Preview {
    ContentView()
        .environmentObject(BatteryManager())
        .environmentObject(BatteryAlertSettings())
}
