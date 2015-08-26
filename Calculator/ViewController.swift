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
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "-": performOperation { $1 - $0 }
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enterKey()
        }
    }
    
    var operandStack = Array<Double>()
    
    
    @IBAction func enterKey() {
        userIsInTheMiddleOfTyping = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
        
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

