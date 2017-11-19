//
//  ViewController.swift
//  StanfordCalc
//
//  Created by Robert Reneau on 11/16/17.
//  Copyright © 2017 Robert Reneau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var currentlyTyping  = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit  = sender.currentTitle!
        
        if currentlyTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay+digit
        }
        else{
            display.text = digit
            currentlyTyping = true
        }
        print ("\(digit) was touched")
        
    }
    // used to make everything a double  (This is a computed Property
    
    var displayValue:Double{
        get{return Double(display.text!)!}
        set{display.text = String(newValue)}
    }
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        currentlyTyping=false
        if let mathematicalSymbol = sender.currentTitle {
            switch mathematicalSymbol {
            case "π":
                displayValue = Double.pi
            case "√":
               displayValue = sqrt(displayValue)
            default:
                break
            }
        }
      }
    
    
    

}
