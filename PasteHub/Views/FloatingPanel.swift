import AppKit
import SwiftUI

final class FloatingPanel: NSPanel, NSWindowDelegate {
    private var isPresented = false

    init(rootView: some View) {
        super.init(
            contentRect: NSRect(x: 0, y: 0, width: 500, height: 620),
            styleMask: [.titled, .closable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: true
        )

        delegate = self
        isFloatingPanel = true
        level = .floating
        isMovableByWindowBackground = true
        titlebarAppearsTransparent = true
        titlebarSeparatorStyle = .none
        titleVisibility = .hidden
        isReleasedWhenClosed = false
        hidesOnDeactivate = false
        animationBehavior = .utilityWindow
        isOpaque = true
        backgroundColor = .windowBackgroundColor
        hasShadow = true
        collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]

        contentViewController = NSHostingController(rootView: rootView)

        center()
    }

    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { false }

    override func close() {
        hide()
    }

    func windowWillClose(_ notification: Notification) {
        isPresented = false
    }

    func toggle() {
        if isPresented {
            hide()
        } else {
            show()
        }
    }

    private func show() {
        isPresented = true
        center()
        NSApp.activate(ignoringOtherApps: true)
        makeKeyAndOrderFront(nil)
        orderFrontRegardless()
    }

    private func hide() {
        isPresented = false
        orderOut(nil)
    }
}
