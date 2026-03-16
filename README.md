# PasteHub

macOS 剪贴板管理工具，自动记录复制的文本、图片和文件，通过全局快捷键快速调出浮动面板，单击即可完成粘贴。

## 功能

- **剪贴板历史** - 自动监听并记录文本、图片、文件三种类型的复制内容，支持按类型筛选和关键词搜索
- **常用片段** - 可将常用文本保存为片段，方便反复使用
- **标签管理** - 为剪贴板条目和片段添加标签，支持按标签过滤
- **全局快捷键** - 默认 `Cmd+Shift+V` 唤出/隐藏面板，可在设置中自定义
- **自动键入** - 单击条目后自动切回先前应用并执行粘贴（需授予辅助功能权限）
- **来源追踪** - 记录并显示复制内容来自哪个应用
- **浮动面板** - 支持从屏幕四个方向（底部/顶部/左侧/右侧）滑入，带动画效果
- **排除应用** - 可设置不记录指定应用的剪贴板内容
- **开机自启** - 支持通过系统 Login Item 开机自动启动

## 系统要求

- macOS 15.0+
- Xcode 16+

## 构建与运行

1. 用 Xcode 打开 `PasteHub/PasteHub.xcodeproj`
2. 选择目标设备后 Build & Run

## 项目结构

```
PasteHub/
├── PasteHubApp.swift              # 应用入口
├── AppDelegate.swift              # 状态栏、面板、快捷键管理
├── Models/
│   ├── ClipboardItem.swift        # 剪贴板条目模型
│   └── SnippetItem.swift          # 常用片段模型
├── Views/
│   ├── ClipboardListView.swift    # 主面板内容视图
│   ├── FloatingPanel.swift        # 浮动面板窗口
│   └── SettingsView.swift         # 设置界面
└── Services/
    ├── ClipboardMonitor.swift     # 剪贴板轮询监听
    ├── ClipboardStore.swift       # 数据持久化与管理
    ├── PasteToAppService.swift    # 自动键入服务
    └── SettingsManager.swift      # 用户偏好管理
```

## 数据存储

历史记录和片段以 JSON 格式存储在 `~/Library/Application Support/PasteHub/` 目录下，图片缓存在同目录的 `Images/` 文件夹中。

## 许可

MIT License
