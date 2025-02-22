# Karla - macOS 电池管理工具

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Karla 是一个简单而实用的 macOS 电池管理工具，它可以帮助你更好地管理笔记本电脑的电池，避免过度充电或过度放电，从而延长电池寿命。

## 主要功能

- 实时监控电池电量和充电状态
- 自定义电量提醒阈值
- 系统通知提醒
- 简洁美观的用户界面
- 测试模式支持

## 系统要求

- macOS 11.0 或更高版本
- Xcode 13.0 或更高版本（用于构建）

## 安装方法

### 方法一：直接下载安装（推荐）

1. 访问 [Release 页面](https://github.com/yourusername/karla/releases) 下载最新版本的 Karla.dmg 文件
2. 双击打开下载的 Karla.dmg 文件
3. 将 Karla.app 拖拽到应用程序文件夹中即可完成安装

### 方法二：从源码构建

1. 克隆仓库到本地：
```bash
git clone https://github.com/yourusername/karla.git
```

2. 使用 Xcode 打开项目：
```bash
cd karla/Karla
open Karla.xcodeproj
```

3. 在 Xcode 中构建和运行项目

## 使用说明

### 基本功能
- 启动应用后，可以在状态栏看到当前电池电量和充电状态
- 双击电池图标可以启用测试模式

### 电量提醒设置
1. 使用滑块选择想要设置的电量阈值
2. 点击"添加提醒"按钮添加新的提醒
3. 可以通过开关控制每个提醒的启用状态
4. 点击垃圾桶图标删除不需要的提醒

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