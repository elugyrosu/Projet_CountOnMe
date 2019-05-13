//
//  Calculator.swift
//  CountOnMe
//
//  Created by Jordan MOREAU on 01/05/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation   // No UIkit in the Model

// MARK: DisplayAlert Protocol
// Protocol to send alert messages, keep alert logic without UIkit in Model

protocol DisplayAlert {
    func showAlert(message: String)
}

// MARK: Calculator Class

class Calculator {
    var displayAlertDelegate: DisplayAlert? // Will get message
    var text = String() // Represent the textView.text
    
    enum Operators: String{
        case addition = "+"
        case substraction = "-"
        case division = "/"
        case multiplication = "*"
    }
    
    // MARK: Properties
    
    var elements: [String] {          // Get and manage numbers and opertors from textView.text to an array
        return text.split(separator: " ").map { "\($0)" }
    }
    
    var expressionIsCorrect: Bool {   // modified for multiplcation and division
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {       // modified for multiplcation and division
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }

    // MARK: Methods
    //  all functions represent one button action from controller
    
    func addNumber(numberText: String) -> String{
        if expressionHaveResult {
            text = ""
        }
        text.append(numberText)
        return text
    }
    
    func addOperator(element: Operators) -> String{
        if expressionHaveResult || text == ""{
            text = ""
            return text
        }
        if canAddOperator{
            text.append(" " + element.rawValue + " ")
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
            if let priorityIndex = operationsToReduce.firstIndex(where: {$0 == "*" || $0 == "/"}){             // get priority for multiple * and /
                    operandIndex = priorityIndex
            }else{
                operandIndex = 1                                                    // other operators at last
            }
            let operand = operationsToReduce[operandIndex]
            guard let left = Double(operationsToReduce[operandIndex - 1]), let right = Double(operationsToReduce[operandIndex + 1])
                else {
                    text = ""
                    displayAlertDelegate?.showAlert(message: "Erreur inconnue !") // due of stability
                    return text
            }
            var result: Double // will change with floorf
            
            switch operand { // add division and multiplication
            case "+": result = left + right
            case "-": result = left - right
            case "*": result = left * right
            case "/":
                if right == 0 {         // check division by zero and reset text
                    displayAlertDelegate?.showAlert(message: "La division par zéro n'existe pas !")
                    text = ""
                    return text
                }else{
                    result = left / right
                }
            default:        // change fatal error by an alert (appear when you calculate the total two times wirhout correct operation)
                displayAlertDelegate?.showAlert(message: "Démarrez un nouveau calcul !")
                return text
            }
            // change localisation in the array (support multiplication / division priority)
            operationsToReduce.remove(at: operandIndex + 1)
            operationsToReduce.remove(at: operandIndex)
            operationsToReduce.remove(at: operandIndex - 1)
            // add integer comparative to round the result to Int if possible (remove .0)
            let isInteger = floor(result)
            if isInteger == result{
                let resultToInt = Int(result)
                operationsToReduce.insert("\(resultToInt)", at: operandIndex - 1)
            }else{
                operationsToReduce.insert("\(result)", at: operandIndex - 1)
            }
        }
        text.append(" = \(operationsToReduce.first!)") // return total
        return text
    }
    
}
