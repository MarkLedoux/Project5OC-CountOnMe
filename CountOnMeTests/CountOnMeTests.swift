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
    // be a bit more precise in the name of the tests

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReduceAddition() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("4")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("5")

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "9")

    }

    func testReduceSubstraction() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("8")

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "1")
    }

    func testPlusMinusResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("8")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("3")

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "14")
    }

    func testMinusPlusResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("8")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("3")

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "4")
    }

    func testPlusPlusResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("8")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("3")

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "20")
    }

    func testMinusMinusResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("8")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("3")

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "-2")
    }

    func testMultiplyMultiplyResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("8")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("3")

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "216")
    }

    func testMultiplyDivisionResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("8")
		calculator.add(mathOperator: .division)
		calculator.addNumber("3")

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "24")
    }

    func testDivisionDivisonResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("12")
		calculator.add(mathOperator: .division)
		calculator.addNumber("2")
		calculator.add(mathOperator: .division)
		calculator.addNumber("6")

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "1")
    }

    func testDivisionMultiplyResolveFromLeftToRight() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("12")
		calculator.add(mathOperator: .division)
		calculator.addNumber("2")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("6")

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "36")
    }

    func testReduceMutltiply() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("8")

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, "72")
    }

    func testReduceDivision() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .division)
		calculator.addNumber("4")

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
		calculator.addNumber("5")
		calculator.add(mathOperator: .division)
		calculator.addNumber("0")

        // When
        calculator.reduce()

        // Then
		XCTAssertEqual(calculator.printedString, CalculatorError.zeroDivisor.localizedDescription)
    }

    func testMinusButton() {
        // Given
        let calculator = Calculator()
        calculator.addNumber("")

        // When
		calculator.add(mathOperator: .substraction)

        // Then
        XCTAssertEqual(calculator.printedString, "0")
    }

    func testPlusButton() {
        // Given
        let calculator = Calculator()
        calculator.addNumber("")

        // When
		calculator.add(mathOperator: .addition)

        // Then
        XCTAssertEqual(calculator.printedString, "0")
    }

    func testMultiplyButton() {
        // Given
        let calculator = Calculator()
        calculator.addNumber("")

        // When
		calculator.add(mathOperator: .multiplication)

        // Then
        XCTAssertEqual(calculator.printedString, "0")
    }

    func testDivideButton() {
        // Given
        let calculator = Calculator()
        calculator.addNumber("")

        // When
		calculator.add(mathOperator: .division)

        // Then

        XCTAssertEqual(calculator.printedString, "0")
    }

    func testEqualButton() {
        // Given
        let calculator = Calculator()

        // When
        calculator.reduce()

        // Then

		XCTAssertEqual(calculator.printedString, CalculatorError.missingElement.localizedDescription)
    }

    func testAddNumber() {
        // Given
        let calculator = Calculator()
        calculator.addNumber("")

        // When
        calculator.addNumber(String(1))

        // Then
        XCTAssertEqual(calculator.printedString, "1")
    }

    func testReduceValidLeftoperator() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("a")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("9")

        // When
        calculator.reduce()

        // Then
		XCTAssertEqual(calculator.printedString, CalculatorError.leftOperatorNotValid.localizedDescription)
    }

    func testReduceValidRighttoperator() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("a")

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, CalculatorError.rightOperatorNotValid.localizedDescription)
    }

    func testAddNumberWhenExpressionHasResult() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("5")
		calculator.reduce()

        // When
        calculator.addNumber("9")

        // Then
        XCTAssertEqual(calculator.printedString, "9")
    }

    func testLeftOperator() {
        // Given
        let calculator = Calculator()
		calculator.add(mathOperator: .substraction)
		calculator.add(mathOperator: .addition)
		calculator.addNumber("5")

        // When
        calculator.reduce()

        //Then
		XCTAssertEqual(calculator.printedString, CalculatorError.missingElement.localizedDescription)
    }

    func testOperandButtonAddition() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("5")
		calculator.add(mathOperator: .substraction)

        // When
		calculator.add(mathOperator: .addition)

        // Then
        XCTAssertEqual(calculator.printedString, "5 + ")
    }

    func testOperandButtonSubstraction() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("5")
		calculator.add(mathOperator: .addition)

        // When
		calculator.add(mathOperator: .substraction)

        // Then
        XCTAssertEqual(calculator.printedString, "5 - ")
    }

    func testOperandButtonDivision() {
        // Given
        let calculator = Calculator()
		calculator.addNumber("5")
		calculator.add(mathOperator: .addition)

        // When
		calculator.add(mathOperator: .division)

        // Then
        XCTAssertEqual(calculator.printedString, "5 ÷ ")
    }

	func testOperandButtonMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("5")
		calculator.add(mathOperator: .addition)

		// When
		calculator.add(mathOperator: .multiplication)

		// Then
		XCTAssertEqual(calculator.printedString, "5 × ")
	}

	func testExpressionHasResult() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("9")
		calculator.reduce()

		// When
		calculator.addNumber("9")

		// Then
		XCTAssertEqual(calculator.printedString, "9")
	}

	func testAdditionMultiplicationPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("5")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("9")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "54")
	}

	func testMultiplicationAdditionPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("5")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("9")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "54")
	}

	func testSubstractionMultiplicationPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("5")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("9")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "-36")
	}

	func testMultiplicationSubstractionPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("5")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("9")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "36")
	}

	func testAdditionDivisionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("9")
		calculator.add(mathOperator: .division)
		calculator.addNumber("3")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "12")
	}

	func testDivisionAdditionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .division)
		calculator.addNumber("9")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("3")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "4")
	}

	func testSubsctractionDivisionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("27")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("9")
		calculator.add(mathOperator: .division)
		calculator.addNumber("3")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "24")
	}

	func testDivisionSubsctractionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("27")
		calculator.add(mathOperator: .division)
		calculator.addNumber("9")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("3")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "0")
	}

	func testAdditionMultiplicationMultiplicationPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("5")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("9")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("3")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "144")
	}

	func testMultiplicationAdditionMultiplicationPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("5")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("9")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("9")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "126")
	}

	func testSubstractionMultiplicationMultiplicationPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("5")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("9")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("9")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "-396")
	}

	func testMultiplicationSubstractionMultiplicationPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("5")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("9")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("9")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "-36")
	}

	func testAdditionDivisionDivisionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("9")
		calculator.add(mathOperator: .division)
		calculator.addNumber("3")
		calculator.add(mathOperator: .division)
		calculator.addNumber("3")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "10")
	}

	func testDivisionAdditionDivisionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .division)
		calculator.addNumber("9")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("3")
		calculator.add(mathOperator: .division)
		calculator.addNumber("5")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "1.6")
	}

	func testSubsctractionDivisionDivisionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("27")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("9")
		calculator.add(mathOperator: .division)
		calculator.addNumber("3")
		calculator.add(mathOperator: .division)
		calculator.addNumber("3")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "26")
	}

	func testDivisionSubsctractionDivisionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("27")
		calculator.add(mathOperator: .division)
		calculator.addNumber("9")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("3")
		calculator.add(mathOperator: .division)
		calculator.addNumber("4")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "2.25")
	}

	func testValidFirstNumberInOperation() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("")

		// When
		calculator.addNumber("0")
		calculator.addNumber("9")

		// Then
		XCTAssertEqual(calculator.printedString, "9")
	}

	func testNonValidtoperator() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.addNumber("a")
		calculator.addNumber("9")

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, CalculatorError.missingElement.localizedDescription)
	}

	func testremoveExtraZero() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("0")

		// When
		calculator.addNumber("8")

		// Then
		XCTAssertEqual(calculator.printedString, "9 - 8")
	}

	func testremoveExtraZeroNoMatterThePlace() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("9")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("0")

		// When
		calculator.addNumber("8")
		calculator.add(mathOperator: .division)
		calculator.addNumber("0")
		calculator.addNumber("5")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("0")
		calculator.addNumber("9")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("0")
		calculator.addNumber("8")

		// Then
		XCTAssertEqual(calculator.printedString, "9 - 8 ÷ 5 × 9 - 8")
	}

	func testVerifyZeroNotRemoved() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("30")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("50")
		calculator.add(mathOperator: .substraction)
		calculator.addNumber("0")

		// When
		calculator.addNumber("3")

		// Then
		XCTAssertEqual(calculator.printedString, "30 × 50 - 3")
	}

	func testVerifyOperationReturnProperResultLeftToRight() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("30")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("50")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("0")

		// When
		calculator.addNumber("3")
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "1503")
	}

	func testVerifyOperationReturnProperResultRightToLeft() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("30")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("50")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("80")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("0")

		// When
		calculator.addNumber("3")
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "4033")
	}

	func testLastElementIsOperator() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("30")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("50")
		calculator.add(mathOperator: .multiplication)
		calculator.addNumber("80")
		calculator.add(mathOperator: .addition)

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, CalculatorError.missingElement.localizedDescription)
	}

	func testIsResultDisplayed() {
		// Given
		let calculator = Calculator()
		calculator.addNumber("30")
		calculator.add(mathOperator: .addition)
		calculator.addNumber("50")

		// When
		calculator.reduce()
		calculator.add(mathOperator: .addition)

		// Then
		XCTAssertEqual(calculator.printedString, "0")
	}
}
