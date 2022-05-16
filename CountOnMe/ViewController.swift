//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    lazy var calculator = Calculator(currentText: textView.text)

    // View actions
    @IBAction func tappedAllClearButton(_ sender: UIButton) {
        calculator.clearAll()
        textView.text = calculator.currentText
    }
    @IBAction func tappedClearLastButton(_ sender: UIButton) {
        calculator.clearLastEntry()
        textView.text = calculator.currentText
        }

// Add Numbers
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addNumber(number: numberText)
            textView.text = calculator.currentText
        }
    // Add Decimal Numbers
    @IBAction func tappedDecimalButton(_ sender: UIButton) {
        guard calculator.addDecimal(symbol: ".")
        else {
            return warnningAlert()
        }
        textView.text = calculator.currentText
    }

// Operator Element

    // Add Operator Addition
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        guard calculator.addOperator(operator: "+") else {
            return warnningAlert()
        }
        textView.text = calculator.currentText
    }
    // Add Operator Substraction
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        guard calculator.addOperator(operator: "-") else {
            return warnningAlert()
        }
        textView.text = calculator.currentText
    }
    // Add Operator Multiplication
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        guard calculator.addOperator(operator: "×") else {
            return warnningAlert()
        }
        textView.text = calculator.currentText
    }
    // Add Operator Division
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        guard calculator.addOperator(operator: "÷") else {
            return warnningAlert()
        }
        textView.text = calculator.currentText
    }
// Calculate elements
    // Calculate % Percentage
    @IBAction func tappedPourCentButton(_ sender: UIButton) {
        if calculator.doThePercent().validity == false {
            alert(title: "Zéro!", description: calculator.doThePercent().message)
        }
        textView.text = calculator.currentText
    }
    // Calculate Equal
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if calculator.doTheMath().validity == false {
            alert(title: "Zéro!", description: calculator.doTheMath().message)
        }
        textView.text = calculator.currentText
    }
    // MARK: - Functions

    fileprivate func alert(title: String, description: String) {
        let alertVC = UIAlertController(title: title, message: description,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    fileprivate func warnningAlert( ) {
        let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
