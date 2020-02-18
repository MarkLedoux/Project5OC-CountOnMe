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
        calculator.resolveEquation()
        
        // Then
        XCTAssertEqual(calculator.printedString , "2 + 2 = 4")
        
    }
    
    func testReduceSubstraction()  {
        // Given

        let calculator = Calculator()
        calculator.printedString = "9 - 8"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "9 - 8 = 1")
    }

    func testReduceMutltiply() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 × 8"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "9 × 8 = 72")
    }

    func testReduceDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 ÷ 4"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "9 ÷ 4 = 2.25")
    }

    func testACButton() {
        // Given
        let calculator = Calculator()

        // When
        calculator.reset()

        // Then
        XCTAssertEqual(calculator.printedString, "")
    }

    func testReduceDivisionByZero() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 ÷ 0"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "Not a number = inf")
    }

    func testMissingElement() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "")
    }

    func testMinusButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.add(operand: " - ")

        // Then
        XCTAssertEqual(calculator.printedString, " - ")
    }

    func testPlusButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.add(operand: " + ")

        // Then
        XCTAssertEqual(calculator.printedString, " + ")
    }

    func testMultiplyButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.add(operand: " × ")

        // Then
        XCTAssertEqual(calculator.printedString, " × ")
    }

    func testDivideButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.add(operand: " ÷ ")

        // Then

        XCTAssertEqual(calculator.printedString, " ÷ ")
    }

    func testEqualButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.resolveEquation()

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
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "Left operator not valid")
    }

    func testReduceValidRighttoperator() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + a"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "Right operator not valid")
    }

    func testUnknownOperator() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 a 9"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "Unknown operator!")
    }

    func testExpressionIsCorrect() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + "
        expectation(forNotification: NSNotification.Name(rawValue: "presentAlertForCorrectExpression"), object: nil, handler: nil)

        // When
        calculator.resolveEquation()

        // Then
        NotificationCenter.default.post(name: NSNotification.Name("presentAlertForCorrectExpression"), object: nil)
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testAddNumberWhenExpressionHasResult() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + 5 = 14"

        // When
        calculator.resolveEquation()

        // Then
        calculator.printedString = " = "
    }

    func testMultiplyButtonTappedAlert() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + "
        expectation(forNotification: NSNotification.Name(rawValue: "presentAlertForElementNumber"), object: nil, handler: nil)

        // When
        calculator.add(operand: " × ")

        // Then
        NotificationCenter.default.post(name: NSNotification.Name("presentAlertForElementNumber"), object: nil)
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testRightOperator() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + -"

        // When
        calculator.resolveEquation()

        // Then
        XCTAssertEqual(calculator.printedString, "Right operator not valid")
    }
    
    func testLeftOperator() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "- + 5"
        
        // When
        calculator.resolveEquation()
        
        //Then
        XCTAssertEqual(calculator.printedString, "Left operator not valid")
    }
    
    func testOperandButtonAddition() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "
        
        // When
        calculator.add(operand: " + ")
        
        // Then
        XCTAssertEqual(calculator.printedString, "5 + ")
    }
    
    func testOperandButtonSubstraction() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "
        
        // When
        calculator.add(operand: " - ")
        
        // Then
        XCTAssertEqual(calculator.printedString, "5 - ")
    }
    
    func testOperandButtonDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "
        
        // When
        calculator.add(operand: " ÷ ")
        
        // Then
        XCTAssertEqual(calculator.printedString, "5 ÷ ")
    }
    
    func testOperandButtonMultiplication() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "
        
        // When
        calculator.add(operand: " × ")
        
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
    
}
