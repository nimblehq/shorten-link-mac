//
//  AppDelegate.swift
//  ShortenLink
//
//  Created by Phong Vo on 12/11/2021.
//

import Cocoa
import AppAuth

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var currentUserSession: OIDExternalUserAgentSession?

    private let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    private let popOver = NSPopover()
    private var eventMonitor: EventMonitor?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        setUpStatusBarIcon()
        setUpPopOver()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationWillUnhide(_ notification: Notification) {
        NSApp.hide(self)
    }

    func application(_ application: NSApplication, open urls: [URL]) {
        guard let url = urls.first else { return }
        currentUserSession?.resumeExternalUserAgentFlow(with: url)
    }
}

extension AppDelegate {

    private func setUpStatusBarIcon() {
        if let button = statusItem.button {
            button.image = Asset.statusBarIcon.image
            button.action = #selector(togglePopover)
        }
    }

    private func setUpPopOver() {
        let linksPopOverViewModel = DependencyFactory.shared.linksPopOverViewModel()
        let controller = LinksPopOverViewController(viewModel: linksPopOverViewModel)
        popOver.contentViewController = controller
        // Handle click outside to close popover
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] in
            if self?.popOver.isShown ?? false {
                self?.closePopOver(sender: $0)
            }
        }
    }

    @objc private func togglePopover(_ sender: Any?) {
        if popOver.isShown {
            closePopOver(sender: sender)
        } else {
            showPopOver(sender: sender)
        }
    }

    private func showPopOver(sender: Any?) {
        if let button = statusItem.button {
            popOver.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            eventMonitor?.start()
        }
    }

    private func closePopOver(sender: Any?) {
        popOver.performClose(sender)
        eventMonitor?.stop()
    }
}
