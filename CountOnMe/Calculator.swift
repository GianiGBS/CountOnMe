//
//  Calculator.swift
//  CountOnMe
//
//  Created by Giovanni Gabriel on 10/04/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    // MARK: - Properties

    var currentText = ""

    var elements: [String] {
        return currentText.split(separator: " ").map { "\($0)" }
    }
// Error check computed variables
    var expressionIsCorrect: Bool {
        expressionOrOperatorIsValid()
    }
    var expressionHasEnoughElement: Bool {
        return elements.count >= 3
    }
    var canAddOperator: Bool {
        expressionOrOperatorIsValid()
    }
    var expressionHasResult: Bool {
        return currentText.firstIndex(of: "=") != nil
    }
    var isDividedByZero: Bool {
        return currentText.contains(" ÷ 0")
    }
// Check if last character of last element is decimal
    var isLastCharacterDecimal: Bool {
        if let lastElement = elements.last {
            if lastElement.suffix(1) == "." {
                return true
            }
        }
        return false
    }

// Check if there already a decimal
    var isDecimal: Bool {
        if isLastCharacterDecimal || numberOfDecimal() > 0 {
            return true
        }
        return false
    }
    // MARK: - Initialization

    init(currentText: String) {
        self.currentText = currentText
    }
    // MARK: - Functions

    func numberOfDecimal() -> Int {
        var decimalCount = 0
        if let lastElement: String = elements.last {
            if lastElement.contains(".") {
                decimalCount += 1
            }
        }
            return decimalCount
    }
    func expressionOrOperatorIsValid() -> Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "x" && elements.last != "÷"
            && !isLastCharacterDecimal
    }
    func addOperator(operator symbol: String) -> Bool {
        guard canAddOperator else {
            return false
        }

        if let lastElement = elements.last, expressionHasResult {
            currentText = lastElement
        }

        currentText += " \(symbol) "
        return true
    }
    func emptyCurrentTextIfExpressionHasResult() {
        if expressionHasResult {
            currentText = ""
        }
    }
    func removeLastEntryOfCurrentText() {
        if expressionHasResult {
            if let firstCharacterToTrim = currentText.firstIndex(of: "=") {
                for character in currentText {
                    if let index = currentText.lastIndex(of: character) {
                        if index >= currentText.index(before: firstCharacterToTrim) {
                            currentText.remove(at: index)
                        }
                    }
                }
            }
        } else if currentText.isEmpty {
            currentText = ""
        } else {
            if let lastCharacter = currentText.last, lastCharacter == " " {
                currentText.removeLast()
            }
            currentText.removeLast()
        }
    }
    func clearLastEntry() {
        if currentText == "0" {
            return
        }

        removeLastEntryOfCurrentText()
    }
    // Add Numbers to Calculate
    func addNumbers(number: String) {
        emptyCurrentTextIfExpressionHasResult()
        currentText.append(number)
    }
    func addDecimal(symbol: String) -> Bool {
        emptyCurrentTextIfExpressionHasResult()
        if !isDecimal {
            currentText.append(".")

            if let lastElement = elements.last, lastElement.count == 1 {
                currentText.removeLast()
                currentText.append("0.")
            }
        }
        return true
    }
// Calculate % Percentage
    func doThePercent() -> (validity: Bool, message: String) {
       // Create local copy of operations
         var operation = elements
        // Iterate over operations while an operand still here
        if operation.count == 1 {
         let left = Float(operation[0])!
         let result: Float = left / 100
            currentText.append("%")
        operation.insert("\(result)", at: 0)
        } else {
            return (false, "Veuillez entrer une expression correcte.")
                }

        if let result = operation.first, let floatResult = Float(result) {
            currentText.append(" = \(floatResult.clean)")
        }
        return (true, "")
    }
// Calculate Equal
    func doTheMath() -> (validity: Bool, message: String) {
        guard expressionIsCorrect else {
            return (false, "Veuillez entrer une expression correcte.")
        }
        guard expressionHasEnoughElement else {
            return (false, "Veuillez démarrer un nouveau calcul.")
        }
        if expressionHasResult {
            if let lastElement = elements.last {
                currentText = lastElement
                return (true, "\(lastElement)")
            }
        }
        var operations = elements
        var result: Float = 0
        var index = 0

        func executeOperation(_ signOperator: SignOperator) {
            if let firstOperand = Float(operations[index-1]), let secondOperand = Float(operations[index+1]) {
                switch signOperator {
                case .addition:
                    result = firstOperand + secondOperand
                case .substraction:
                    result = firstOperand - secondOperand
                case .multiplication:
                    result = firstOperand * secondOperand
                case .division:
                    result = firstOperand / secondOperand
            }
            operations.remove(at: index+1)
            operations.remove(at: index)
            operations.remove(at: index-1)
            operations.insert("\(result)", at: index-1)
            index = 0
        }
    }
    // Iterate over operations while an operator still here
        while index < operations.count - 1 {
            if operations.contains("×") || operations.contains("÷") {
                if operations[index] == "×" {
                    executeOperation(.multiplication)
                } else if operations[index] == "÷" {
                    if isDividedByZero {
                        return (false, "Impossible de diviser par 0 !")
                    } else {
                        executeOperation(.division)
                    }
                }
            } else {
                if operations[index] == "+" {
                    executeOperation(.addition)
                } else if operations[index] == "-" {
                    executeOperation(.substraction)
                }
            }
            index += 1
        }

        if let result = operations.first, let floatResult = Float(result) {
            currentText.append(" = \(floatResult.clean)")
        }
    return (true, "")
}
    // MARK: - Fileprivate enumeration
    fileprivate enum SignOperator {
        case addition, substraction, multiplication, division
    }
}
