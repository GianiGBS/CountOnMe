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
        calculator.addDecimal(symbol: ".")
        calculator.addNumber(number: "5")

        XCTAssert(calculator.isDecimal == true)
        XCTAssert(calculator.currentText == "2.5")
    }
// All Clear
    func testGiven_WhenTapAllClear_ThenRemoveAll() {
        calculator.addNumber(number: "10")
        calculator.addOperator(operator: "+")// "x"
        calculator.addNumber(number: "6")
        calculator.clearAll()

        XCTAssert(calculator.currentText == "")
    }
 }
