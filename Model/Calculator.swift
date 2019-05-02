//
//  Calculator.swift
//  CountOnMe
//
//  Created by Jordan MOREAU on 01/05/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//


import Foundation

class Calculator {
    
    var text = String()
    
    var elements: [String] {
        return text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables

    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }
    
    
    func calculTotal() -> Bool {
        // Create local copy of operations

        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default:
                return false
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        text.append(" = \(operationsToReduce.first!)")
        return true
    }
}
