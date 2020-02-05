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
        let countOnMe = CountOnMe()
        countOnMe.printedString = "2 + 2"
        
        // When
        countOnMe.reduce()
        
        // Then
        XCTAssertEqual(countOnMe.printedString , "2 + 2 = 4")
        
    }
    
    func testReduceSubstraction()  {
        // Given
        
        let countOnMe = CountOnMe()
        countOnMe.printedString = "9 - 8"
        
        // When
        countOnMe.reduce()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, "9 - 8 = 1")
    }
    
    func testReduceMutltiply() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = "9 x 8"
        
        // When
        countOnMe.reduce()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, "9 x 8 = 72")
    }
    
    func testReduceDivision() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = "9 ÷ 4"
        
        // When
        countOnMe.reduce()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, "9 ÷ 4 = 2.25")
    }
    
    func testACButton() {
        // Given
        let countOnMe = CountOnMe()
        
        // When
        countOnMe.acButtonTapped()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, "")
    }
    
    func testReduceDivisionByZero() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = "5 ÷ 0"
        
        // When
        countOnMe.reduce()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, "Not a number = inf")
    }
    
    func testMissingElement() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = "5 + "
        
        // When
        countOnMe.reduce()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, "")
    }
    
    func testMinusButton() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = ""
        
        // When
        countOnMe.minusButtonTapped()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, " - ")
    }
    
    func testPlusButton() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = ""
        
        // When
        countOnMe.plusButtonTapped()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, " + ")
    }
    
    func testMultiplyButton() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = ""
        
        // When
        countOnMe.multiplyButtonTapped()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, " x ")
    }
    
    func testDivideButton() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = ""
        
        // When
        countOnMe.divideButtonTapped()
        
        // Then
        
        XCTAssertEqual(countOnMe.printedString, " ÷ ")
    }
    
    func testEqualButton() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = ""
        
        // When
        countOnMe.equalButtonTapped()
        
        // Then
        
        XCTAssertEqual(countOnMe.printedString, "")
    }
    
    func testAddNumber() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = ""
        
        // When
        countOnMe.addNumber(String(1))
        
        // Then
        XCTAssertEqual(countOnMe.printedString, "1")
    }
    
    func testReduceValidLeftoperator() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = "a + 9"
        
        // When
        countOnMe.reduce()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, "Left operator not valid")
    }
    
    func testReduceValidRighttoperator() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = "9 + a"
        
        // When
        countOnMe.reduce()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, "Right operator not valid")
    }
    
    func testUnknownOperator() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = "9 a 9"
        
        // When
        countOnMe.reduce()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, "Unknown operator!")
    }
    
    func testExpressionIsCorrect() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = "9 + "
        expectation(forNotification: NSNotification.Name(rawValue: "presentAlertForCorrectExpression"), object: nil, handler: nil)
        
        // When
        countOnMe.equalButtonTapped()
        
        // Then
        NotificationCenter.default.post(name: NSNotification.Name("presentAlertForCorrectExpression"), object: nil)
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testAddNumberWhenExpressionHasResult() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = "9 + 5 = 14"
        
        // When
        countOnMe.equalButtonTapped()
        
        // Then
        countOnMe.printedString = " = "
    }
    
    func testMultiplyButtonTappedAlert() {
        // Given
        let countOnMe = CountOnMe()
        countOnMe.printedString = "9 + "
        expectation(forNotification: NSNotification.Name(rawValue: "presentAlertForElementNumber"), object: nil, handler: nil)
        
        // When
        countOnMe.multiplyButtonTapped()
        
        // Then
        NotificationCenter.default.post(name: NSNotification.Name("presentAlertForElementNumber"), object: nil)
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
