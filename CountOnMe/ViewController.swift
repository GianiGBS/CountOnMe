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

    var calculator = Calculator()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // View actions
    @IBAction func tappedAllClearButton(_ sender: UIButton) {
            textView.text.removeAll()
    }

    @IBAction func tappedNegativeButton(_ sender: UIButton) {
            textView.text.append(" - ")
        }
// Operator %
    @IBAction func tappedPourCentButton(_ sender: UIButton) {
    }
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if calculator.expressionHaveResult {
            textView.text = calculator.currentText
        }
        textView.text.append(numberText)
    }
// Operator Addition
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            textView.text.append(" + ")
        } else {
            warnningAlert()
        }
    }
// Operator Substraction
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            textView.text.append(" - ")
        } else {
            warnningAlert()
        }
    }
// Operator Multiplication
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if calculator.expressionOrOperatorIsValid() {
            textView.text.append(" x ")
        } else {
            warnningAlert()
        }
    }
// Operator Division
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if calculator.canAddOperator {
            textView.text.append(" ÷ ")
        } else {
            warnningAlert()
        }
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

        guard calculator.expressionHaveEnoughElement
        else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !",
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        calculator.doTheMath()
    }
    fileprivate func warnningAlert() {
        let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
