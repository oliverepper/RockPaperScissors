//
//  MainWindowController.swift
//  RockPaperScissors
//
//  Created by Oliver Epper on 22.03.21.
//

import SwiftUI

class MainWindowController: NSWindowController {

    override var windowNibName: NSNib.Name? {
        .init("MainWindowController")
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        let appKit = RockPaperScissorsViewController()
        appKit.title = "AppKit"
        let swiftUI = NSHostingController(rootView: RockPaperScissorsView())
        swiftUI.title = "SwiftUI"

        let tabViewController = NSTabViewController()
        tabViewController.addChild(appKit)
        tabViewController.addChild(swiftUI)
        contentViewController = tabViewController

        window?.setContentSize(swiftUI.view.frame.size)
    }
}
