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
    
    // 
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
    
    func calculateTotal() -> String{
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
    
            if operationsToReduce.contains("*") && operationsToReduce.contains("/"){
                if let multiplicationIndex = operationsToReduce.firstIndex(of: "*"){
                    if let divisionIndex = operationsToReduce.firstIndex(of: "/"){
                        if multiplicationIndex < divisionIndex{
                            operandIndex = multiplicationIndex
                        }else{
                            operandIndex = divisionIndex
                        }
                    }
                }
            }else{
                if operationsToReduce.contains("*"){
                    if let multplicationIndex = operationsToReduce.firstIndex(of: "*"){
                        operandIndex = multplicationIndex
                    }
                }else{
                    if operationsToReduce.contains("/"){
                        if let divisionIndex = operationsToReduce.firstIndex(of: "/"){
                            operandIndex = divisionIndex
                        }
                    }else{
                        operandIndex = 1
                    }
                }
            }
            let operand = operationsToReduce[operandIndex]
            guard let left = Float(operationsToReduce[operandIndex - 1]), let right = Float(operationsToReduce[operandIndex + 1])
                else {
                    text = ""
                    displayAlertDelegate?.showAlert(message: "Expression incorrecte !")

                    return text
                    
                }
            
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

            operationsToReduce.insert("\(result.clean)", at: operandIndex - 1)
        }
        
        text.append(" = \(operationsToReduce.first!)")
        return text
    }
    
}

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
