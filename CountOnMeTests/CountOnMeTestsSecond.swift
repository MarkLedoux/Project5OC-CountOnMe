//
//  CountOnMeTestsSecond.swift
//  CountOnMeTests
//
//  Created by Mark LEDOUX  on 17/03/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTestsSecond: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOperandButtonMultiplication() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "

        // When
        calculator.add(operators: " × ")

        // Then
        XCTAssertEqual(calculator.printedString, "5 × ")
    }

    func testExpressionHasResult() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 × 9 = 81"

        // When
        calculator.addNumber("9")

        // Then
        XCTAssertEqual(calculator.printedString, "9")
    }

    func testAdditionMultiplicationPriorityForMultiplication() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + 5 × 9"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "54")
    }

    func testMultiplicationAdditionPriorityForMultiplication() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 × 5 + 9"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "54")
    }

    func testSubstractionMultiplicationPriorityForMultiplication() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 - 5 × 9"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "-36")
    }

    func testMultiplicationSubstractionPriorityForMultiplication() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 × 5 - 9"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "36")
    }

    func testAdditionDivisionPriorityForDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + 9 ÷ 3"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "12")
    }

    func testDivisionAdditionPriorityForDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 ÷ 9 + 3"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "4")
    }

    func testSubsctractionDivisionPriorityForDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "27 - 9 ÷ 3"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "24")
    }

    func testDivisionSubsctractionPriorityForDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "27 ÷ 9 - 3"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "0")
    }

    func testAdditionMultiplicationMultiplicationPriorityForMultiplication() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + 5 × 9 × 3"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "144")
    }

    func testMultiplicationAdditionMultiplicationPriorityForMultiplication() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 × 5 + 9 × 9"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "126")
    }

    func testSubstractionMultiplicationMultiplicationPriorityForMultiplication() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 - 5 × 9 × 9"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "-396")
    }

    func testMultiplicationSubstractionMultiplicationPriorityForMultiplication() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 × 5 - 9 × 9"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "-36")
    }

    func testAdditionDivisionDivisionPriorityForDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + 9 ÷ 3 ÷ 3"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "10")
    }

    func testDivisionAdditionDivisionPriorityForDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 ÷ 9 + 3 ÷ 5"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "1.6")
    }

    func testSubsctractionDivisionDivisionPriorityForDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "27 - 9 ÷ 3 ÷ 3"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "26")
    }

    func testDivisionSubsctractionDivisionPriorityForDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "27 ÷ 9 - 3 ÷ 4"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "2.25")
    }

    func testValidFirstNumberInOperation() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.addNumber("0")
        calculator.addNumber("9")

        // Then
        XCTAssertEqual(calculator.printedString, "9")
    }

    func testNonValidtoperator() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 a 9"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, CalculatorError.unknownOperator.localizedDescription)
    }

    func testremoveExtraZero() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 - 0"

        // When
        calculator.addNumber("8")

        // Then
        XCTAssertEqual(calculator.printedString, "9 - 8")
    }
}
