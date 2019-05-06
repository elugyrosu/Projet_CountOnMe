//
//  Calculator.swift
//  CountOnMe
//
//  Created by Jordan MOREAU on 01/05/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol DisplayAlert {
    func showAlert(message: String)
}

class Calculator {
    var displayAlertDelegate: DisplayAlert?
    
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
    
    
    func addNumber(numberText: String) -> String{
        if expressionHaveResult {
            text = ""
        }
        
        text.append(numberText)
        return text
    }
    func addPlus() -> String{
        if canAddOperator {
            text.append(" + ")
        } else {
            displayAlertDelegate?.showAlert(message: "Un operateur est déja mis !")

        }
        return text
    }
    
    func addMinus() -> String{
        if canAddOperator {
            text.append(" - ")
        } else {
            displayAlertDelegate?.showAlert(message: "Un operateur est déja mis !")
        }
        return text
    }
    
    func addMultiplication() -> String{
        if canAddOperator {
            text.append(" * ")
        } else {
            displayAlertDelegate?.showAlert(message: "Un operateur est déja mis !")
        }
        return text
    }
    
    func addDivision() -> String{
        if canAddOperator {
            text.append(" / ")
        } else {
            displayAlertDelegate?.showAlert(message: "Un operateur est déja mis !")
        }
        return text
    }
    
    func calculate() -> String{
        guard expressionIsCorrect else {
            displayAlertDelegate?.showAlert(message: "Entrez une expression correcte !")
            return text
        }
        
        guard expressionHaveEnoughElement else {
            displayAlertDelegate?.showAlert(message: "Démarrez un nouveau calcul !")
            return text

        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            
            var operandIndex = Int()
    
            if operationsToReduce.contains("*"){
                operandIndex = operationsToReduce.firstIndex(of: "*")!
            }else{
                if operationsToReduce.contains("/"){
                    operandIndex = operationsToReduce.firstIndex(of: "/")!
                }else{
                    operandIndex = 1
                }
            }
            let left = Float(operationsToReduce[operandIndex - 1])!
            let operand = operationsToReduce[operandIndex]
            let right = Float(operationsToReduce[operandIndex + 1])!
            
            let result: Float
            switch operand {

            case "+": result = left + right
            case "-": result = left - right
            case "*": result = left * right
            case "/": result = left / right
     
            default:
                displayAlertDelegate?.showAlert(message: "Démarrez un nouveau calcul !")
                return text
            }
            operationsToReduce.remove(at: operandIndex + 1)
            operationsToReduce.remove(at: operandIndex)
            operationsToReduce.remove(at: operandIndex - 1)

            operationsToReduce.insert("\(result)", at: operandIndex - 1)
        }
        
        text.append(" = \(operationsToReduce.first!)")
        return text
    }
    

}
