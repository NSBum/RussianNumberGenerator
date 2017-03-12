//
//  Generator.swift
//  RussianNumberSpeaker
//
//  Created by Alan Duncan on 2017-03-11.
//  Copyright © 2017 Ojisan Seiuchi. All rights reserved.
//

import Foundation

class Generator {
    var begin:Int?
    var end:Int?
    enum mode {
        case sequential,random
    }
    var useMode:mode?
    var step:Int?
    var count:Int?
    var location:URL?
    var delegate:GeneratorDelegate!
    
    init(start:Int,stop:Int, theMode:mode, savingTo:URL) {
        begin=start
        end = stop
        useMode = theMode
        location = savingTo
    }
    
    func generate() {
        let talker = Talker(vox: "Yuri")
        if useMode == .sequential {
            for n in stride(from: begin!, through: end!, by: step!) {
                talker.sayNumber(n: n, saveURL: location!)
            }
        }
        else if useMode == .random {
            //  keep track of numbers we've already generated
            var generated = [Int]()
            while count! > 1 {
                let n = randomNumber(min: begin!, max: end!)
                while( !generated.contains(n) ) {
                    generated.append(n)
                    talker.sayNumber(n: n, saveURL: location!)
                    count! -= 1
                }
            }
        }
        if( self.delegate != nil ) {
            delegate.generationDidFinish(self)
        }
    }
    func randomNumber(min: Int, max: Int) -> Int {
        let randomNum = Int(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
        return randomNum
    }
}

protocol GeneratorDelegate {
    func generationDidFinish(_ generator:Generator)
}
