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

// Addition
    func testGivenAdd_WhenTapEqual_ThenResultIsSum() {
        calculator.currentText = "1 + 1"
        calculator.doTheMath()
    }
// Substraction
    func testGivenSubtract_WhenTapEqual_ThenResultIsDifference() {
    }
// Multiplication
    func testGivenMultiply_WhenTapEqual_ThenResultIsProduct() {
    }
// Division
    func testGivenDivide_WhenTapEqual_ThenResultIsQuotient() {
    }
// Priority
    func testGivenMultiOperator_WhenTapEqual_ThenResultIsPriority() {
    }
// Number
    func testGivenIsEmpty_WhenTapNumber_ThenNumberAppear() {
    }
}
