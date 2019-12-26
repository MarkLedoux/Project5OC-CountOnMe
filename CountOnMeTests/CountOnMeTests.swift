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
        countOnMe.printedString = "9 ÷ 3"
        
        // When
        countOnMe.reduce()
        
        // Then
        XCTAssertEqual(countOnMe.printedString, "9 ÷ 3 = 3")
    }

}
