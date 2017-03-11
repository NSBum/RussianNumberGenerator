//
//  ViewController.swift
//  RussianNumberSpeaker
//
//  Created by Alan Duncan on 2017-03-10.
//  Copyright © 2017 Ojisan Seiuchi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, GeneratorDelegate {
    dynamic var beginNumber:Int = 1000
    dynamic var testString:String = "boo"
    dynamic var endNumber:Int = 2000
    dynamic var step:Int = 10
    dynamic var count:Int = 20
    @IBOutlet var saveLocationField:NSTextField?
    @IBOutlet var progressIndicator:NSProgressIndicator?
    @IBOutlet var progressTextField:NSTextField?
    dynamic var saveLocation:URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        progressTextField?.stringValue = ""
        progressIndicator?.usesThreadedAnimation = true
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func warnNoLocation() {
        progressTextField?.stringValue = "Save location not set."
    }
    
    @IBAction func generateButtonPressed(button:NSButton) {
        if( saveLocationField?.stringValue == "" ) {
            warnNoLocation()
            progressIndicator?.startAnimation(self)
        }
    }
    
    @IBAction func generateRandomButtonPressed(button:NSButton) {
        if( saveLocationField?.stringValue == "" ) {
            warnNoLocation()
        }
        else {
            let sequenceGenerator = Generator(start: beginNumber, stop: endNumber, theMode: .random, savingTo: saveLocation!)
            sequenceGenerator.count = count
            sequenceGenerator.delegate = self
            sequenceGenerator.generate()
        }
    }

    func generationDidFinish(_ generator: Generator) {
        self.progressIndicator?.stopAnimation(self)
        progressTextField!.stringValue = "Completed generating audio files."
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.progressTextField?.stringValue = ""
        })
    }

    @IBAction func saveLocationPressed(button:NSButton) {
        let openDialog = NSOpenPanel()
        openDialog.title = "Choose save directory"
        openDialog.showsHiddenFiles = false
        openDialog.canChooseFiles = false
        openDialog.canChooseDirectories = true
        openDialog.canCreateDirectories = true
        openDialog.allowsMultipleSelection = false
        
        if( openDialog.runModal() == NSModalResponseOK ) {
            let result = openDialog.url
            if( result != nil ) {
                saveLocation = result
                let path = result!.path
                saveLocationField?.stringValue = path
                progressTextField?.textColor = NSColor.black
                progressTextField?.stringValue = "Save path set"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.progressTextField?.stringValue = ""
                })
            }
        }
    }
}

