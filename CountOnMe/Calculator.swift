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
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" && !isLastCharacterDecimal
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
    // Add Numbers to Calculate
    func addNumbers(number: String) {
        emptyCurrentTextIfExpressionHasResult()
        currentText.append(number)
    }
    func addDecimal(symbol: String) -> Bool {
        emptyCurrentTextIfExpressionHasResult()
        if !isDecimal {
            currentText.append(",")

            if let lastElement = elements.last, lastElement.count == 1 {
                currentText.removeLast()
                currentText.append("0.")
            }
        }
        return true
    }
    func doThePercent() {}
    func doTheMath() {
        // Create local copy of operations
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!
            let result: Float

            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "÷": result = left / right
            default: fatalError("Unknown operator !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        currentText.append(" = \(operationsToReduce.first!)")
    }
}
