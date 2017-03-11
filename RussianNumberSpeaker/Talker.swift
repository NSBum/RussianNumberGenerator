//
//  Talker.swift
//  RussianNumberSpeaker
//
//  Created by Alan Duncan on 2017-03-11.
//  Copyright © 2017 Ojisan Seiuchi. All rights reserved.
//

import Cocoa

class Talker {
    var voice:String?
    var synth = NSSpeechSynthesizer()
    
    init(vox:String) {
        if vox == "Yuri" {
            synth.setVoice("com.apple.speech.synthesis.voice.yuri.premium")
        }
    }
    func say(str:String,saveURL:URL) {
        let audioConverter = AiffConverter()
        
        let fullURL = saveURL.appendingPathComponent(str).appendingPathExtension("aiff")
        synth.startSpeaking(str, to: fullURL)
        while(NSSpeechSynthesizer.isAnyApplicationSpeaking() == true) {}
        //  convert to mp3
        let mp3URL = fullURL.deletingPathExtension().appendingPathExtension("mp3")
        audioConverter.convert(source:fullURL , destination: mp3URL)
    }
    
    func sayNumber(n:Int,saveURL:URL) {
        self.say(str: String(n),saveURL: saveURL)
    }
}
