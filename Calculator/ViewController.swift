//
//  ViewController.swift
//  Calculator
//
//  Created by Matt Ksiazek on 8/25/15.
//  Copyright (c) 2015 Matt Ksiazek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    //Green arrow pointing from controller to model
    
    var brain = CalculatorModel()
    
    

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }

    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            enterKey()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enterKey() {
        userIsInTheMiddleOfTyping = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            //TODO make displayValue an optional
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        } set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTyping = false
        }
    }
}

