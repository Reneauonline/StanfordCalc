//
//  ViewController.swift
//  StanfordCalc
//
//  Created by Robert Reneau on 11/16/17.
//  Copyright © 2017 Robert Reneau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    
    // Label links
    @IBOutlet weak var eventList: UILabel!
    @IBOutlet weak var display: UILabel!
    
// variables
    var currentlyTyping  = false
    private var brain = CalculatorBrain()
    var event2 = ""
    var eventReset :Bool = false
    
// used to make everything a double  (This is a computed Property and keeps you from turning things into double over and over each time
    var displayValue:Double{
        get{return Double(display.text!)!}
        set{display.text = String(newValue)}
    }
    
    @IBAction func clear(_ sender: UIButton) {
        event2=""
        display.text = "0"
        eventList.text = event2
        
    }
    
// Button Directions
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit  = sender.currentTitle!
        
        if currentlyTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay+digit
            event2 = event2 + digit
            eventList.text = event2
 print ("\(digit) was touched currently typing = false") // not required only for debug
        }
        else{
            
            
                display.text = digit
                    event2 = event2 + digit
                    eventList.text = event2
                currentlyTyping = true
                
                print ("\(digit) was touched") // not required only for debug

            
        }
        
    }
 
    @IBAction func performOperation(_ sender: UIButton) {
        
        if currentlyTyping {
            brain.setOperand(displayValue)
            currentlyTyping=false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
        brain.performOperation(mathematicalSymbol)
            
            
    print ("\(mathematicalSymbol) was touched")
            
            if mathematicalSymbol != "=" {
                event2 = event2 + " " + mathematicalSymbol + " "}
            else{
            // event2 = "-"
                //eventReset = true
            }
            
        }
        
        // return results of calculator if there is a value in result
        if let result = brain.result{
            displayValue = result
            eventList.text = event2
        }
        
        
        
    }
    
}

