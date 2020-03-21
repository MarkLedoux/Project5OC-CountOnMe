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

    func testReduceAddition() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "4 + 5"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "9")

    }

    func testReduceSubstraction() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 - 8"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "1")
    }

    func testPlusMinusResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + 8 - 3"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "14")
    }

    func testMinusPlusResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 - 8 + 3"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "4")
    }

    func testPlusPlusResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + 8 + 3"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "20")
    }

    func testMinusMinusResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 - 8 - 3"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "-2")
    }

    func testMultiplyMultiplyResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 × 8 × 3"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "216")
    }

    func testMultiplyDivisionResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 × 8 ÷ 3"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "24")
    }

    func testDivisionDivisonResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "12 ÷ 2 ÷ 6"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "1")
    }

    func testDivisionMultiplyResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "12 ÷ 2 × 6"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "36")
    }

    func testReduceMutltiply() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 × 8"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "72")
    }

    func testReduceDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 ÷ 4"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "2.25")
    }

    func testACButton() {
        // Given
        let calculator = Calculator()

        // When
        calculator.reset()

        // Then
        XCTAssertEqual(calculator.printedString, "0")
    }

    func testReduceDivisionByZero() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 ÷ 0"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "Not a number")
    }

    func testMinusButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.add(operators: " - ")

        // Then
        XCTAssertEqual(calculator.printedString, " - ")
    }

    func testPlusButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.add(operators: " + ")

        // Then
        XCTAssertEqual(calculator.printedString, " + ")
    }

    func testMultiplyButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.add(operators: " × ")

        // Then
        XCTAssertEqual(calculator.printedString, " × ")
    }

    func testDivideButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.add(operators: " ÷ ")

        // Then

        XCTAssertEqual(calculator.printedString, " ÷ ")
    }

    func testEqualButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.reduce()

        // Then

        XCTAssertEqual(calculator.printedString, "Element missing")
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

    func testAddNumberWhenExpressionHasResult() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + 5 = 14"

        // When
        calculator.addNumber("9")

        // Then
        XCTAssertEqual(calculator.printedString, "9")
    }

    func testLeftOperator() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "- + 5"

        // When
        calculator.reduce()

        //Then
        XCTAssertEqual(calculator.printedString, "Left operator not valid")
    }

    func testOperandButtonAddition() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "

        // When
        calculator.add(operators: " + ")

        // Then
        XCTAssertEqual(calculator.printedString, "5 + ")
    }

    func testOperandButtonSubstraction() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "

        // When
        calculator.add(operators: " - ")

        // Then
        XCTAssertEqual(calculator.printedString, "5 - ")
    }

    func testOperandButtonDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "

        // When
        calculator.add(operators: " ÷ ")

        // Then
        XCTAssertEqual(calculator.printedString, "5 ÷ ")
    }
}
