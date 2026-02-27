import SwiftUI

@main
struct PasteHubApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        MenuBarExtra("PasteHub", systemImage: "list.clipboard") {
            Button("显示 / 隐藏面板") {
                appDelegate.togglePanel()
            }
            .keyboardShortcut("v", modifiers: [.command, .shift])
            Divider()
            Button("清空记录") {
                appDelegate.store.clearAll()
            }
            Divider()
            Button("退出 PasteHub") {
                NSApp.terminate(nil)
            }
        }
    }
}
