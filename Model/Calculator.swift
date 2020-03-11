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

    var printedString: String = "1 + 1 = 2" {
        didSet {
            sendNotification(name: .receivedDataFromCountOnMe)
        }
    }

    // MARK: Methods
    /// Set printedString to "" then add a number
    func addNumber(_ numberText: String) {
        if expressionHaveResult {
            printedString = ""
        }
        printedString.append(numberText)
    }
    /// contains operators or is last element operator?
    func add(operators: String) {
        checkCanAddOperator()
        checkExtraOperator()
        printedString.append(operators)
    }
    /// resetting whatever value held by printedString to 0 then nothing so a new operation can be started
    func reset() {
        printedString = "0"
    }
    /// is expression correct and has enough elements?
    func resolveEquation() {
        guard expressionIsCorrect else {
            return sendNotification(name: .presentAlertForCorrectExpression)
        }

        guard expressionHaveEnoughElement else {
            return sendNotification(name: .presentAlertForElementNumber)
        }
        reduce()
    }

    // MARK: - Private

    // MARK: Properties
    /// separating all the elements of printedString so they can be used individually throughout the code
    private var elements: [String] {
        return printedString.split(separator: " ").map { "\($0)" }
    }

    /// is printedString final element an operator?
    private var expressionIsCorrect: Bool {
        return !isLastElementOperator
    }
    /// making sure that the elements composing printedString are always above or equal to 3
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    /// Is  the last element an operator, is printedString > 0?
    private var canAddOperator: Bool {
        return !isLastElementOperator && printedString.count > 0
    }
    /// returns a boolean after checking is the last element in elements is an operator
    private var isLastElementOperator: Bool {
        guard let lastElement = elements.last else { return false }
        return operators.contains(lastElement)
    }
    /// check if the previous expression was processed successfully
    private var expressionHaveResult: Bool {
        return printedString.firstIndex(of: "=") != nil
    }
    /// array of all the 4 operators which can be used in the application
    private var operators = ["+", "-", "×", "÷"]

    private var isElementsContainingOperators: Bool {
        /// Check if the operators are contained in the array of not
        for operand in operators where elements.contains(operand) {
            return true
        }
        return false
    }

    // MARK: Methods - Private
    /// operationsToReduce contains priority operator?
    private func operationContainsPriorityOperator(operationsToReduce: [String]) -> Bool {
        operationsToReduce.contains { isPriorityOperator(mathOperator: $0) }
    }
    /// processing all the elements contained in printedString to return a result
    private func reduce() {
        do { try checkEquationValidity() } catch { return }

        // Create local copy of operations
        var operationsToReduce = elements
        /// when looping in the array, the minimum value of the first index
        var currentOperationUnitIndex = 0

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            /// Assigning operators a value of currentUnitIndex + 1
            let mathOperator = operationsToReduce[currentOperationUnitIndex + 1]
            /// Check if operationsToReduce still contains priority operators
            let operationsContainsPriorityOperator = operationContainsPriorityOperator(operationsToReduce: operationsToReduce)
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

            guard operators.contains(mathOperator) else {
                printedString = "Unknown operator!"
                return
            }

            guard let rightValue = Double(right) else {
                printedString = "Right operator not valid"
                return
            }

            let result: Double
            switch mathOperator {
            case "+": result = leftValue + rightValue
            case "-": result = leftValue - rightValue
            case "×": result = leftValue * rightValue
            case "÷":
                do { try verifyCanDivide(leftValue, by: rightValue) } catch {
                    printedString = CalculatorError.zeroDivisor.localizedDescription
                    return
                }
                result = leftValue / rightValue
            default: fatalError(CalculatorError.unknownOperator.localizedDescription)
            }
            cleanEquation(operationsToReduce: &operationsToReduce,
                          result: result, currentOperationUnitIndex: currentOperationUnitIndex)
            // setting currentOperationUnitIndex back to 0 at the end of the loop
            currentOperationUnitIndex = 0
        }
    }

    private func checkEquationValidity() throws {
        // handling possible errors in case the expression processed doesn't contain all the necessary elements
        guard expressionHaveEnoughElement else {
            printedString = CalculatorError.missingElement.localizedDescription
            return
        }

        guard isElementsContainingOperators else {
            printedString = CalculatorError.unknownOperator.localizedDescription
            return
        }
    }

    private func cleanEquation(operationsToReduce: inout [String], result: Double, currentOperationUnitIndex: Int) {
        operationsToReduce.remove(at: currentOperationUnitIndex)
        operationsToReduce.remove(at: currentOperationUnitIndex)
        operationsToReduce.remove(at: currentOperationUnitIndex)
        operationsToReduce.insert("\(result.clean)", at: currentOperationUnitIndex)

        guard let resultToPrint = operationsToReduce.first else {
            return
        }
        printedString = resultToPrint
    }

    private func checkCanAddOperator() {
        guard canAddOperator else {
            sendNotification(name: .presentAlert)
            return
        }
    }

    private func sendNotification(name: Notification.Name) {
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
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
    private func checkExtraOperator() {
        // TODO: fix problem that occurs since no range is defined when calling the function, need to check whether the operations to reduce is lower than 2
        let operationForReduce = elements

        if isElementsContainingOperators {
            guard operationForReduce.count < 3 else {
                print("index is out of range")
                return
            }
            guard let index = printedString.index(printedString.startIndex,
                                                  offsetBy: 2,
                                                  limitedBy: printedString.endIndex) else {
                print("index is out of range")
                return
            }
            guard let secondaryIndex = printedString.index(printedString.startIndex,
                                                           offsetBy: 1,
                                                           limitedBy: printedString.endIndex) else {
                print("index is out of range")
                return
            }
            printedString.remove(at: index)
            printedString.remove(at: secondaryIndex)
            printedString.remove(at: secondaryIndex)
        }
    }
}
