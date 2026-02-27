import AppKit
import SwiftUI

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private(set) var store = ClipboardStore()
    private var monitor: ClipboardMonitor!
    private var panel: FloatingPanel!
    private var globalMonitor: Any?
    private var localMonitor: Any?

    func applicationDidFinishLaunching(_ notification: Notification) {
        monitor = ClipboardMonitor(store: store)
        monitor.start()

        store.onClipboardWrite = { [weak self] in
            self?.monitor.syncChangeCount()
        }

        setupPanel()
        setupHotKey()
    }

    func applicationWillTerminate(_ notification: Notification) {
        teardownMonitors()
    }
    // MARK: - Floating Panel

    private func setupPanel() {
        panel = FloatingPanel(rootView: ClipboardListView(store: store))
    }

    @objc func togglePanel() {
        panel?.toggle()
    }

    // MARK: - Global Hot Key (Cmd+Shift+V)

    private func setupHotKey() {
        globalMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if Self.isHotKey(event) {
                Task { @MainActor in self?.togglePanel() }
            }
        }

        localMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if Self.isHotKey(event) {
                Task { @MainActor in self?.togglePanel() }
                return nil
            }
            return event
        }
    }

    private func teardownMonitors() {
        monitor?.stop()

        if let globalMonitor {
            NSEvent.removeMonitor(globalMonitor)
            self.globalMonitor = nil
        }
        if let localMonitor {
            NSEvent.removeMonitor(localMonitor)
            self.localMonitor = nil
        }
    }

    private nonisolated static func isHotKey(_ event: NSEvent) -> Bool {
        let flags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
        return flags == [.command, .shift] && event.keyCode == 9
    }

}
