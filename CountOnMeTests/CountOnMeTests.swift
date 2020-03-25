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
		XCTAssertEqual(calculator.printedString, CalculatorError.zeroDivisor.localizedDescription)
    }

    func testMinusButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
		calculator.add(operators: .substraction)

        // Then
        XCTAssertEqual(calculator.printedString, " \(MathOperator.substraction.rawValue) ")
    }

    func testPlusButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
		calculator.add(operators: .addition)

        // Then
        XCTAssertEqual(calculator.printedString, " \(MathOperator.addition.rawValue) ")
    }

    func testMultiplyButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
		calculator.add(operators: .multiplication)

        // Then
        XCTAssertEqual(calculator.printedString, " \(MathOperator.multiplication.rawValue) ")
    }

    func testDivideButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
		calculator.add(operators: .division)

        // Then

        XCTAssertEqual(calculator.printedString, " \(MathOperator.division.rawValue) ")
    }

    func testEqualButton() {
        // Given
        let calculator = Calculator()
        calculator.printedString = ""

        // When
        calculator.reduce()

        // Then

		XCTAssertEqual(calculator.printedString, CalculatorError.missingElement.localizedDescription)
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
		XCTAssertEqual(calculator.printedString, CalculatorError.leftOperatorNotValid.localizedDescription)
    }

    func testReduceValidRighttoperator() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "9 + a"

        // When
        calculator.reduce()

        // Then
        XCTAssertEqual(calculator.printedString, CalculatorError.rightOperatorNotValid.localizedDescription)
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
		XCTAssertEqual(calculator.printedString, CalculatorError.leftOperatorNotValid.localizedDescription)
    }

    func testOperandButtonAddition() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "

        // When
		calculator.add(operators: .addition)

        // Then
        XCTAssertEqual(calculator.printedString, "5 + ")
    }

    func testOperandButtonSubstraction() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "

        // When
		calculator.add(operators: .substraction)

        // Then
        XCTAssertEqual(calculator.printedString, "5 - ")
    }

    func testOperandButtonDivision() {
        // Given
        let calculator = Calculator()
        calculator.printedString = "5 + "

        // When
		calculator.add(operators: .division)

        // Then
        XCTAssertEqual(calculator.printedString, "5 ÷ ")
    }

	func testOperandButtonMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "5 + "

		// When
		calculator.add(operators: .multiplication)

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
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "54")
	}

	func testMultiplicationAdditionPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "9 × 5 + 9"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "54")
	}

	func testSubstractionMultiplicationPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "9 - 5 × 9"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "-36")
	}

	func testMultiplicationSubstractionPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "9 × 5 - 9"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "36")
	}

	func testAdditionDivisionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "9 + 9 ÷ 3"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "12")
	}

	func testDivisionAdditionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "9 ÷ 9 + 3"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "4")
	}

	func testSubsctractionDivisionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "27 - 9 ÷ 3"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "24")
	}

	func testDivisionSubsctractionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "27 ÷ 9 - 3"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "0")
	}

	func testAdditionMultiplicationMultiplicationPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "9 + 5 × 9 × 3"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "144")
	}

	func testMultiplicationAdditionMultiplicationPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "9 × 5 + 9 × 9"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "126")
	}

	func testSubstractionMultiplicationMultiplicationPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "9 - 5 × 9 × 9"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "-396")
	}

	func testMultiplicationSubstractionMultiplicationPriorityForMultiplication() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "9 × 5 - 9 × 9"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "-36")
	}

	func testAdditionDivisionDivisionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "9 + 9 ÷ 3 ÷ 3"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "10")
	}

	func testDivisionAdditionDivisionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "9 ÷ 9 + 3 ÷ 5"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "1.6")
	}

	func testSubsctractionDivisionDivisionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "27 - 9 ÷ 3 ÷ 3"

		// When
		calculator.reduce()

		// Then
		XCTAssertEqual(calculator.printedString, "26")
	}

	func testDivisionSubsctractionDivisionPriorityForDivision() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "27 ÷ 9 - 3 ÷ 4"

		// When
		calculator.reduce()

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
		calculator.reduce()

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

	func testremoveExtraZeroNoMatterThePlace() {
		// Given
		let calculator = Calculator()
		calculator.printedString = "9 - 0"

		// When
		calculator.addNumber("8")
		calculator.add(operators: .division)
		calculator.addNumber("0")
		calculator.addNumber("5")
		calculator.add(operators: .multiplication)
		calculator.addNumber("0")
		calculator.addNumber("9")
		calculator.add(operators: .substraction)
		calculator.addNumber("0")
		calculator.addNumber("8")

		// Then
		XCTAssertEqual(calculator.printedString, "9 - 8 ÷ 5 × 9 - 8")
	}
}
