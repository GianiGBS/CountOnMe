//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    var calculator: Calculator!
    var result = "0"

    override func setUp() {
        super.setUp()
        calculator = Calculator(currentText: "")
    }
//  Number
    func testGivenCalculTextIsEmpty_WhenAddNumber_ThenNumberAppear() {
        calculator.addNumber(number: "1")

        XCTAssert(calculator.currentText == "1")
        }
// Addition
    func testGivenAdd_WhenTapEqual_ThenResultIsSum() {
        calculator.currentText = "1 + 1 = 2"
        _ = calculator.doTheMath()

        XCTAssertEqual(calculator.currentText, "2")
    }
//  Substraction
    func testGivenSubtract_WhenTapEqual_ThenResultIsDifference() {
        calculator.currentText = "3 - 1 = 2"
        _ = calculator.doTheMath()

        XCTAssertEqual(calculator.currentText, "2")
    }
//  Multiplication
    func testGivenMultiply_WhenTapEqual_ThenResultIsProduct() {
        calculator.currentText = "1 × 2 = 2"
        _ = calculator.doTheMath()

        XCTAssertEqual(calculator.currentText, "2")
    }
//  Division
    func testGivenDivide_WhenTapEqual_ThenResultIsQuotient() {
        calculator.currentText = "4 ÷ 2 = 2"
        _ = calculator.doTheMath()

        XCTAssertEqual(calculator.currentText, "2")
    }
//  Priority
    func testGivenMultiOperator_WhenTapEqual_ThenResultIsPriority() {
        calculator.currentText = "1 × 1 + 4 ÷ 2  = 3"
        _ = calculator.doTheMath()

        XCTAssertEqual(calculator.currentText, "3")
    }
//  Decimal Number
    func testGivenNumberWasAdd_WhenAddDecimalAndNumber_ThenDecimalNumberAppear() {
        calculator.addNumber(number: "2")
        _ = calculator.addDecimal(symbol: ".")
        calculator.addNumber(number: "5")

        XCTAssert(calculator.isDecimal == true)
        XCTAssertEqual(calculator.currentText, "2.5")
    }
    func testGivenCurrentTextIsEmpty_WhenAddDecimalAndAddNumber5_Then0Appear() {
        calculator.currentText = ""
        _ = calculator.addDecimal(symbol: ".")
        calculator.addNumber(number: "5")

        XCTAssertEqual(calculator.currentText, "0.5")
    }
// All Clear
    func testGivenIs10MultipliedBy6_WhenTapClearAll_ThenRemoveAll() {
        calculator.currentText = "10 x 6"
        calculator.clearAll()

        XCTAssertEqual(calculator.currentText, "")
    }
// Clear Last Entry
    func testGivenIs2Plus4_WhenTapClearLastEntry_ThenRemoveLastElement() {
        calculator.currentText = "2 + 4"
        calculator.clearLastEntry()

        XCTAssertEqual(calculator.currentText, "2 + ")
    }
// Percentage
    func testGivenIs10_WhenTapPercent_ThenResultIsQuotient() {
        calculator.currentText = "10"
        _ = calculator.doThePercent()

        XCTAssertEqual(calculator.currentText, "0.1")
    }
// Percentage w Decimal
    func testGivenIsDecimal_WhenTapPercent_ThenResultIsQuotient() {
        calculator.currentText = "5.5"
        _ = calculator.doThePercent()

        XCTAssertEqual(calculator.currentText, "0.055")
    }
// Percentage w 0
    func testGivendIs0_WhenTapPercent_ThenValidityElementReturnFalse() {
        calculator.currentText = "0"

        XCTAssertEqual(calculator.doThePercent().validity, false)
        XCTAssertEqual(calculator.doThePercent().message, "Veuillez entrer une expression correcte.")
    }
// Divided by 0
    func testGivendIs7Divided0_WhenTapEqual_ThenValidityElementReturnFalse() {
        calculator.currentText = "7 ÷ 0"

        XCTAssertEqual(calculator.doTheMath().validity, false)
        XCTAssertEqual(calculator.doTheMath().message, "Impossible de diviser par 0 !")
    }
// Operator
    func testGivendIs2Plus4Plus_WhenTapEqual_ThenValidityElementReturnFalse() {
        calculator.currentText = "2 + 4 +"

        XCTAssertEqual(calculator.doTheMath().validity, false)
        XCTAssertEqual(calculator.doTheMath().message, "Veuillez entrer une expression correcte.")
    }
// Add operator conecutively
    func testGivenIs4Plus_WhenMinusOperatorButtonTapped_ThenCanAddOperatorBooleanShouldReturnFalse() {
            calculator.currentText = "4 + "

            _ = calculator.addOperator(operator: "-")

            XCTAssertFalse(calculator.canAddOperator)
        }
 }
