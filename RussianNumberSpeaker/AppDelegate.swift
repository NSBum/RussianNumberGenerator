//
//  AppDelegate.swift
//  RussianNumberSpeaker
//
//  Created by Alan Duncan on 2017-03-10.
//  Copyright © 2017 Ojisan Seiuchi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupDefaults()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func setupDefaults() {
        let defaults = UserDefaults.standard
        defaults.set("~/Desktop", forKey:"saveLocation")
    }
}

