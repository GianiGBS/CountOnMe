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
        calculator.currentText.removeAll()
        textView.text = calculator.currentText
    }
    @IBAction func tappedNegativeButton(_ sender: UIButton) {
        calculator.currentText.append(" - ")
        textView.text = calculator.currentText
        }
    @IBAction func tappedDecimalButton(_ sender: UIButton) {
        guard calculator.addDecimal(symbol: ",")
//        calculator.currentText.append(",")
//        textView.text = calculator.currentText
        else {
            return warnningAlert()
        }
        textView.text = calculator.currentText
    }
// Add Numbers
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addNumbers(number: numberText)
            textView.text = calculator.currentText
        }

// Calculate Element
    // Add % Division by 100
    @IBAction func tappedPourCentButton(_ sender: UIButton) {
        calculator.doThePercent()
        textView.text = calculator.currentText
            }
    // Add Operator Addition
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        guard calculator.addOperator(operator: "+")
//            calculator.currentText.append(" + ")
//            textView.text = calculator.currentText
//    }
        else {
            return warnningAlert()
        }
        textView.text = calculator.currentText
    }
    // Add Operator Substraction
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        guard calculator.addOperator(operator: "-")
//            calculator.currentText.append(" - ")
//            textView.text = calculator.currentText
//        }
        else {
            return warnningAlert()
        }
        textView.text = calculator.currentText
    }
    // Add Operator Multiplication
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        guard calculator.addOperator(operator: "x")
//            calculator.currentText.append(" x ")
//            textView.text = calculator.currentText
//        }
        else {
            return warnningAlert()
        }
        textView.text = calculator.currentText
    }
    // Add Operator Division
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        guard calculator.addOperator(operator: "÷")
//            calculator.currentText.append(" ÷ ")
//            textView.text = calculator.currentText
//        }
        else {
            return warnningAlert()
        }
        textView.text = calculator.currentText
    }

    // Operator Equal
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionOrOperatorIsValid()
        else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !",
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
            }

        guard calculator.expressionHasEnoughElement
        else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !",
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
            }
        calculator.doTheMath()
        textView.text = calculator.currentText
    }
    // MARK: - Functions

    fileprivate func warnningAlert() {
        let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
