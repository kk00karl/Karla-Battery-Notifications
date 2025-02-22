import Foundation

struct BatteryAlert: Codable, Identifiable {
    var id = UUID()
    var threshold: Int
    var isEnabled: Bool
    var message: String
}

class BatteryAlertSettings: ObservableObject {
    @Published var alerts: [BatteryAlert] {
        didSet {
            save()
        }
    }
    
    private let saveKey = "BatteryAlerts"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([BatteryAlert].self, from: data) {
            self.alerts = decoded
        } else {
            // 默认提醒设置
            self.alerts = [
                BatteryAlert(threshold: 20, isEnabled: true, message: "电池电量低于20%"),
                BatteryAlert(threshold: 80, isEnabled: true, message: "电池电量已达80%，请拔掉电源")
            ]
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(alerts) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
} 