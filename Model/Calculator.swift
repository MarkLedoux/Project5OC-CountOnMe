//
//  CountOnMe.swift
//  CountOnMe
//
//  Created by Mark LEDOUX on 20/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol ArithmeticElement {
}

extension Int: ArithmeticElement {
}

class Calculator {
    
    // MARK: - Internal
    
    // MARK: Properties
    
    var printedString: String = "1 + 1 = 2"
    
    // MARK: Methods
    
    func addNumber(_ numberText: String) {
        if expressionHaveResult {
            printedString = ""
        }
        printedString.append(numberText)
        sendNotification(name:.receivedDataFromCountOnMe)
    }
    
    func add(operand: String) {
        checkCanAddOperator()
        checkExtraOperand()
        printedString.append(operand)
        sendNotification(name: .receivedDataFromCountOnMe)
    }
    
    func reset() {
        // when the button is tapped so it sends data to the controller
        printedString = "0"
        sendNotification(name: .receivedDataFromCountOnMe)
        printedString = ""
    }
    
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
    
    private var elements: [String] {
        return printedString.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    private var expressionIsCorrect: Bool {
        return !isLastElementOperator
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return !isLastElementOperator && printedString.count > 0
    }
    
    private var isLastElementOperator: Bool {
        guard let lastElement = elements.last else { return false }
        return operands.contains(lastElement)
    }
    
    private var expressionHaveResult: Bool {
        return printedString.firstIndex(of: "=") != nil
    }
    
    private var operands: [String] { ["+", "-", "×", "÷"] }
    
    private var isElementsContainingOperators: Bool {
        for operand in operands where elements.contains(operand) {
            return true
        }
        
        return false
    }
    
    // MARK: Methods - Private
    
    private func reduce() {
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            
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
    private func checkExtraOperand() {
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
