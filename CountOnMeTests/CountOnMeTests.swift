//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Mark LEDOUX  on 17/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ReduceAddition() {
        
        // Given
        let calculator = Calculator()
        calculator.printedString = "2 + 2"
        
        // When
        calculator.reduce()
        
        // Then
        XCTAssertEqual(calculator.printedString , "2 + 2 = 4")
        
    }
    
    func testReduceSubstraction()  {
        // Given

        let calculator = Calculator()
        calculator.printedString = "9 - 8"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "9 - 8 = 1")
    }

    func testReduceMutltiply() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 × 8"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "9 × 8 = 72")
    }

    func testReduceDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 ÷ 4"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "9 ÷ 4 = 2.25")
    }

    func testACButton() {
        // Given
        let calculator = Calculator()

        // When
        calculator.acButtonTapped()

        // Then
        XCTAssertEqual(calculator.printedString, "")
    }

    func testReduceDivisionByZero() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 ÷ 0"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "Not a number = inf")
    }

    func testMissingElement() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "")
    }

    func testMinusButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.minusButtonTapped()

        // Then
        XCTAssertEqual(calculator.printedString, "")
    }

    func testPlusButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.plusButtonTapped()

        // Then
        XCTAssertEqual(calculator.printedString, "")
    }

    func testMultiplyButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.multiplyButtonTapped()

        // Then
        XCTAssertEqual(calculator.printedString, "")
    }

    func testDivideButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.divideButtonTapped()

        // Then

        XCTAssertEqual(calculator.printedString, "")
    }

    func testEqualButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.equalButtonTapped()

        // Then

        XCTAssertEqual(calculator.printedString, "")
    }

    func testAddNumber() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.addNumber(String(1))

        // Then
        XCTAssertEqual(calculator.printedString, "1")
    }

    func testReduceValidLeftoperator() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "a + 9"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "Left operator not valid")
    }

    func testReduceValidRighttoperator() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + a"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "Right operator not valid")
    }

    func testUnknownOperator() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 a 9"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "Unknown operator!")
    }

    func testExpressionIsCorrect() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + "
        expectation(forNotification: NSNotification.Name(rawValue: "presentAlertForCorrectExpression"), object: nil, handler: nil)

        // When
        calculator.equalButtonTapped()

        // Then
        NotificationCenter.default.post(name: NSNotification.Name("presentAlertForCorrectExpression"), object: nil)
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testAddNumberWhenExpressionHasResult() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + 5 = 14"

        // When
        calculator.equalButtonTapped()

        // Then
        calculator.printedString = " = "
    }

    func testMultiplyButtonTappedAlert() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + "
        expectation(forNotification: NSNotification.Name(rawValue: "presentAlertForElementNumber"), object: nil, handler: nil)

        // When
        calculator.multiplyButtonTapped()

        // Then
        NotificationCenter.default.post(name: NSNotification.Name("presentAlertForElementNumber"), object: nil)
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
