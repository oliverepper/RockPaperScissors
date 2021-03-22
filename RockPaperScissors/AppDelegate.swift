//
//  AppDelegate.swift
//  RockPaperScissors
//
//  Created by Oliver Epper on 22.03.21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController: NSWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainWindowController = MainWindowController()
        mainWindowController.showWindow(nil)
        self.mainWindowController = mainWindowController
    }
}

