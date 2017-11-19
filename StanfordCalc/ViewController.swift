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
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if currentlyTyping {
            brain.setOperand(displayValue)
            currentlyTyping=false
        }
        if let mathematicalSymbol = sender.currentTitle { brain.performOperation(mathematicalSymbol)}
        // return results of calculator if there is a value in result
        if let result = brain.result{
            displayValue = result
        }
      }
    
    
    

}
