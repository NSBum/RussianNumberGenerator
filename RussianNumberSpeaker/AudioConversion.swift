//
//  AudioConversion.swift
//  RussianNumberSpeaker
//
//  Created by Alan Duncan on 2017-03-11.
//  Copyright © 2017 Ojisan Seiuchi. All rights reserved.
//

import Foundation

class AiffConverter {
    func convert(source:URL,destination:URL) {
        let task = Process()
        task.launchPath = "/usr/local/bin/ffmpeg"
        task.arguments = ["-y","-i",source.path,destination.path]
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        let fm = FileManager.default
        do {
            try fm.removeItem(at: source)
        }
        catch {
            fatalError("Unable to delete aiff file")
        }
    }
}
