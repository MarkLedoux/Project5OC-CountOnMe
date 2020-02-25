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
    
    var printedString: String = "1 + 1 = 2"
    
    // MARK: Methods
    /// check if the previous operation properly returned a result and if it did, setting printedString to have nothing before appending a new number which will then show up on the view
    func addNumber(_ numberText: String) {
        if expressionHaveResult {
            printedString = ""
        }
        printedString.append(numberText)
        sendNotification(name:.receivedDataFromCountOnMe)
    } 
    /// check that the printedString doesn't contain operators for its last elements before seeing is it already contains operators and if it doesn't add a new operator to printedString
    func add(operators: String) {
        checkCanAddOperator()
        checkExtraOperator()
        printedString.append(operators)
        sendNotification(name: .receivedDataFromCountOnMe)
    }
    /// resetting whatever value held by printedString to 0 then nothing so a new operation can be started
        func reset() {
        printedString = "0"
        sendNotification(name: .receivedDataFromCountOnMe)
        printedString = ""
    }
    /// pressring the equal button triggers this function, checking that the expression countains all the necessay elements
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
    
    /// making sure that when an operation is made, printedString final element isn't an operator and returns a bool if it is the case
    private var expressionIsCorrect: Bool {
        return !isLastElementOperator
    }
    /// making sure that the elements composing printedString are always above or equal to 3
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    /// check that the final element isn't an operator and that the number of elements in printedString is superior to 0, returns true if the condition are met
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
    private var operators: [String] { ["+", "-", "×", "÷"] }
     
    private var isElementsContainingOperators: Bool {
        /// loop through the array of operators and see for each case if the operators are contained in the array of not and returning a boolean once an answer is reached
        for operand in operators where elements.contains(operand) {
            return true
        }
        return false
    }
    
    // MARK: Methods - Private
    /// processing all the elements contained in printedString to return a result
    private func reduce() {
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            // handling possible errors in case the expression processed doesn't contain all the necessary elements 
            guard expressionHaveEnoughElement else {
                printedString = CalculatorError.missingElement.localizedDescription
                sendNotification(name: .receivedDataFromCountOnMe)
                printedString = ""
                return
            }
            
            guard isElementsContainingOperators else {
                printedString = CalculatorError.unknownOperator.localizedDescription
                return
            }
            
            let left = operationsToReduce[0]
            let operand = operationsToReduce[1]
            let right = operationsToReduce[2]
            
            
            guard let leftValue = Double(left) else {
                printedString = "Left operator not valid"
                sendNotification(name: .receivedDataFromCountOnMe)
                return
            }
            
            guard let rightValue = Double(right) else {
                printedString = "Right operator not valid"
                sendNotification(name: .receivedDataFromCountOnMe)
                return
            }
            
            
            let result: Double
            switch operand {
            case "+": result = leftValue + rightValue
            case "-": result = leftValue - rightValue
            case "×": result = leftValue * rightValue
            case "÷": result = leftValue / rightValue
            default: fatalError(CalculatorError.unknownOperator.localizedDescription)
            }
            
            do { try divisionError(leftValue, by: rightValue) }
            catch { printedString = CalculatorError.zeroDivisor.localizedDescription }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result.clean)", at: 0)
            printedString.append(" = \(operationsToReduce.first!)")
            sendNotification(name: .receivedDataFromCountOnMe)
        }
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
    
    private func divisionError(_ left: Double, by right: Double) throws {
        guard right != 0 else {
            throw CalculatorError.zeroDivisor
        }
    }
    
    
    /// check to see if an operand is contained within printedString and if true then remove the copy of the operand
    private func checkExtraOperator() {
        // TODO: fix problem that occurs since no range is defined when calling the function, need to check whether the operations to reduce is lower than 2
        let operationForReduce = elements
        
        print(printedString)
        
        if isElementsContainingOperators {
            guard operationForReduce.count < 3 else {
                print("index is out of range")
                return
            }
            guard let index = printedString.index(printedString.startIndex,offsetBy: 2, limitedBy: printedString.endIndex) else {
                print("index is out of range")
                return
            }
            guard let secondaryIndex = printedString.index(printedString.startIndex,offsetBy: 1, limitedBy: printedString.endIndex) else {
                print("index is out of range")
                return
            }
            printedString.remove(at: index)
            printedString.remove(at: secondaryIndex)
            printedString.remove(at: secondaryIndex)
        }
    }
}
