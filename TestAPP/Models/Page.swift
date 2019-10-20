//
//  Page.swift
//  TestAPP
//
//  Created by Justin Zaw on 20/10/2019.
//  Copyright © 2019 Justin Zaw. All rights reserved.
//


import Foundation
import UIKit

struct Page{
    private var char:Character;
    private var colorValue:UInt;
    private var colorValueHex:String {
 
        return String(format:"%02X", colorValue)
    }
    var htmlString: String{
       return   """
                <html>
                <div style=position:absolute;top:50%;left:50%;  >
                        <h1  >
                                <a style=color:#\(colorValueHex);font-size: 8.5em;font-wieght:bold>\(self.char)</a>
                            </h1>
                      </div>
                </html>
           """
         
    }
    init(){
       let aScalars = "a".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value

        let letters: [Character] = (0..<26).map {
            i in Character(UnicodeScalar(aCode + i) ?? "x")
        }

        char = letters.randomElement() ?? "X"
        colorValue =   UInt(arc4random_uniform(0xffffff))
    }
}

