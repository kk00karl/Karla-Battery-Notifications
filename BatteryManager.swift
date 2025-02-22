import Foundation
import IOKit.ps

class BatteryManager: ObservableObject {
    @Published var batteryLevel: Double = 0
    @Published var isCharging: Bool = false
    @Published var isTestMode: Bool = false
    
    private var timer: Timer?
    private var lastLevel: Double = 0
    
    init() {
        updateBatteryStatus() // 初始化时立即更新一次
        startMonitoring()
    }
    
    func startMonitoring() {
        // 改回3分钟更新一次
        timer = Timer.scheduledTimer(withTimeInterval: 180, repeats: true) { [weak self] _ in
            self?.updateBatteryStatus()
        }
    }
    
    private func updateBatteryStatus() {
        let snapshot = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let sources = IOPSCopyPowerSourcesList(snapshot).takeRetainedValue() as Array
        
        for source in sources {
            let info = IOPSGetPowerSourceDescription(snapshot, source).takeUnretainedValue() as! [String: Any]
            
            if let capacity = info[kIOPSCurrentCapacityKey] as? Int {
                let newLevel = Double(capacity) / 100.0
                // 改回1%的变化阈值
                if abs(newLevel - lastLevel) >= 0.01 {
                    batteryLevel = newLevel
                    lastLevel = newLevel
                    checkBatteryAlerts()
                }
            }
            
            if let charging = info[kIOPSPowerSourceStateKey] as? String {
                isCharging = charging == kIOPSACPowerValue
            }
        }
    }
    
    private func checkBatteryAlerts() {
        guard let settings = try? UserDefaults.standard.data(forKey: "BatteryAlerts"),
              let alerts = try? JSONDecoder().decode([BatteryAlert].self, from: settings) else {
            return
        }
        
        let currentLevel = Int(batteryLevel * 100)
        
        for alert in alerts where alert.isEnabled {
            // 简单地检查电量是否达到阈值
            if currentLevel == alert.threshold {
                NotificationManager.shared.sendNotification(
                    title: "电池电量提醒",
                    body: "当前电量为\(currentLevel)%"
                )
            }
        }
    }
    
    func setTestValues(level: Double, charging: Bool) {
        guard isTestMode else { return }
        batteryLevel = min(max(level, 0), 1)
        isCharging = charging
        checkBatteryAlerts()
    }
    
    deinit {
        timer?.invalidate()
    }
} 