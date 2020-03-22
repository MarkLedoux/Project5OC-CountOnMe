//
//  CountOnMe.swift
//  CountOnMe
//
//  Created by Mark LEDOUX on 20/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {

	// MARK: - Internal

	// MARK: Properties
	weak var delegate: CalculatorDelegate?

	var printedString: String = "1 + 1 = 2" {
		didSet {
			delegate?.didUpdatePrintedString()
		}
	}

	// MARK: Methods
	/// Set printedString to "" then add a number
	func addNumber(_ numberText: String) {
		isEmpty()
		removeExtraZero()
		if expressionHaveResult {
			printedString = ""
		}

		printedString.append(numberText)
	}

	/// contains operators or is last element operator?
	func add(operators: String) {
		removeFirstOperator()
		printedString.append(operators)
	}

	/// resetting whatever value held by printedString to 0 then nothing so a new operation can be started
	func reset() {
		printedString = "0"
	}

	/// processing all the elements contained in printedString to return a result
	func reduce() {
		do {
			try checkEquationValidity()
		} catch CalculatorError.unknownOperator {
			return
		} catch CalculatorError.missingElement {
			return
		} catch {}

		// Create local copy of operations
		var operationsToReduce = elements
		/// when looping in the array, the minimum value of the first index
		var currentOperationUnitIndex = 0

		// Iterate over operations while an operand still here
		while operationsToReduce.count > 1 {
			/// Assigning operators a value of currentUnitIndex + 1
			let mathOperator = operationsToReduce[currentOperationUnitIndex + 1]
			/// Check if operationsToReduce still contains priority operators
			let operationsContainsPriorityOperator =
				operationContainsPriorityOperator(operationsToReduce: operationsToReduce)
			let isPriorityOperators = isPriorityOperator(mathOperator: mathOperator)
			/// Check for priority operator and first loop
			guard isPriorityOperators || !operationsContainsPriorityOperator else {
				currentOperationUnitIndex += 2
				continue
			}
			/// Setting UnitIndex back to zero when not on first loop
			if !operationsContainsPriorityOperator {
				currentOperationUnitIndex = 0
			}
			///Giving left and right UnitIndex value of 0 and 2
			let left = operationsToReduce[currentOperationUnitIndex]
			let right = operationsToReduce[currentOperationUnitIndex + 2]

			guard let leftValue = Double(left) else {
				printedString = "Left operator not valid"
				return
			}

			guard let rightValue = Double(right) else {
				printedString = "Right operator not valid"
				return
			}

			let result: Double
			switch mathOperator {
			case Operators.addition.rawValue: result = leftValue + rightValue
			case Operators.substraction.rawValue: result = leftValue - rightValue
			case Operators.multiplication.rawValue: result = leftValue * rightValue
			case Operators.division.rawValue:
				do { try verifyCanDivide(leftValue, by: rightValue) } catch {
					printedString = CalculatorError.zeroDivisor.localizedDescription
					return
				}
				result = leftValue / rightValue
			default:
				assertionFailure(CalculatorError.unknownOperator.localizedDescription)
				return
			}
			cleanEquation(operationsToReduce: &operationsToReduce,
						  result: result, currentOperationUnitIndex: currentOperationUnitIndex)
			// setting currentOperationUnitIndex back to 0 at the end of the loop
			currentOperationUnitIndex = 0
		}
	}

	// MARK: - Private

	// MARK: Properties
	/// separating all the elements of printedString so they can be used individually throughout the code
	private var elements: [String] {
		return printedString.split(separator: " ").map { "\($0)" }
	}

	/// making sure that the elements composing printedString are always above or equal to 3
	private var expressionHaveEnoughElement: Bool {
		return elements.count >= 3
	}

	/// check if the previous expression was processed successfully
	private var expressionHaveResult: Bool {
		return printedString.firstIndex(of: "=") != nil
	}

	private var isElementsContainingOperators: Bool {
		/// Check if the operators are contained in the array of not
		for operand in Operators.allCases where elements.contains(operand.rawValue) {
			return true
		}
		return false
	}

	private var numberFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 5

		formatter.numberStyle = .decimal
		return formatter
	}()

	// MARK: Methods - Private
	/// operationsToReduce contains priority operator?
	private func operationContainsPriorityOperator(operationsToReduce: [String]) -> Bool {
		operationsToReduce.contains { isPriorityOperator(mathOperator: $0) }
	}

	private func checkEquationValidity() throws {
		// handling possible errors in case the expression processed doesn't contain all the necessary elements
		guard expressionHaveEnoughElement else {
			printedString = CalculatorError.missingElement.localizedDescription
			throw CalculatorError.missingElement
		}

		guard isElementsContainingOperators else {
			printedString = CalculatorError.unknownOperator.localizedDescription
			throw CalculatorError.unknownOperator
		}
	}

	private func formatNumberToString(number: Double) -> String? {
		return numberFormatter.string(from: number as NSNumber)
	}

	private func cleanEquation(operationsToReduce: inout [String], result: Double, currentOperationUnitIndex: Int) {

		guard let resultAsString = formatNumberToString(number: result) else { return }

		operationsToReduce.remove(at: currentOperationUnitIndex)
		operationsToReduce.remove(at: currentOperationUnitIndex)
		operationsToReduce.remove(at: currentOperationUnitIndex)
		operationsToReduce.insert(resultAsString, at: currentOperationUnitIndex)

		guard let resultToPrint = operationsToReduce.first else {
			return
		}
		printedString = resultToPrint
	}

	/// Verifying that the left value can be divide by the right value
	private func verifyCanDivide(_ left: Double, by right: Double) throws {
		guard right != 0 else {
			throw CalculatorError.zeroDivisor
		}
	}

	/// check in the operators to see whether the operators used are piority operators or not and returning a boolean
	private func isPriorityOperator(mathOperator: String) -> Bool {
		switch mathOperator {
		case "×", "÷": return true
		default: return false
		}
	}

	/// check to see if an operand is contained within printedString and if true then remove the copy of the operand
	private func removeFirstOperator() {

		//  check if the last element is an operator and if it is delete it and replace it by the new one
		//        let contains = operators.contains(where: printedString.contains)
		//
		//        if contains {
		//            printedString.removeLast()
		////        }
		//        for operand in operators {
		//            while printedString.contains(operand) {
		//                printedString.removeLast()
		//            }
		//        }
	}

	private func isEmpty() {
		if !printedString.isEmpty || printedString.isEmpty {
			if printedString.first == "0" {
				printedString = ""
			}
		}
	}

	private func removeExtraZero() {
		//        print(printedString)
		//        if printedString.count > 2 {
		//            print()
		//            print("Printed is currently: \(printedString)")
		//            if printedString.hasSuffix(String(operators.contains(where: printedString.contains))) {
		//                if printedString.first == "0" {
		//                    printedString.remove(at: printedString.endIndex)
		//                }
		//            }
		//        }
	}
}
