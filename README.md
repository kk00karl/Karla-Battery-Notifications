# Karla - macOS 电池管理工具

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Karla 是一个简单而实用的 macOS 电池管理工具，它可以帮助你更好地管理笔记本电脑的电池，避免过度充电或过度放电，从而延长电池寿命。

## 主要功能

- 实时监控电池电量和充电状态
- 自定义电量提醒阈值
- 系统通知提醒
- 简洁美观的用户界面

## 开发说明

### 项目结构
- `BatteryManager.swift`: 电池状态监控和管理
- `BatteryAlertSettings.swift`: 电量提醒设置管理
- `NotificationManager.swift`: 系统通知管理
- `ContentView.swift`: 主界面 UI 实现
- `KarlaApp.swift`: 应用程序入口

### 技术特点
- 使用 SwiftUI 构建现代化用户界面
- 采用 MVVM 架构模式
- 使用 UserDefaults 持久化存储设置
- 使用 IOKit 框架获取电池信息

## 贡献指南

欢迎提交 Issue 和 Pull Request 来帮助改进这个项目。

## 开源协议

本项目采用 MIT 协议开源，详见 [LICENSE](LICENSE) 文件。

## 第一次发布开源项目希望各位多多支持
