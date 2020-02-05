//
//  CountOnMe.swift
//  CountOnMe
//
//  Created by Mark LEDOUX on 20/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

// Enum with the cases of errors handled in the app
private enum CalculatorError: Error {
    case zeroDivisor
    case missingElement
    case unknowOperator
}

// Extension explaining what the program needs to return depending on the error return by the program
extension CalculatorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .zeroDivisor:
            return "Not a number"
        case .missingElement:
            return "Element missing"
        case .unknowOperator:
            return "Unknow operator!"
        }
    }
}

// Extension used to return a truncated result when a multiplication, addition or substraction is made, thus removing the decimal
extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Notification.Name {
    static let receivedDataFromCountOnMe = Notification.Name("receivedDataFromCountOnMe")
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

class CountOnMe {

    var printedString: String = "1 + 1 = 2"

    var elements: [String] {
        return printedString.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return (elements.last != "+" && elements.last != "-") || (elements.last != "x" && elements.last != "÷")
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return (elements.last != "+" && elements.last != "-") || (elements.last != "x" && elements.last != "÷")
    }
    
    var expressionHaveResult: Bool {
        return printedString.firstIndex(of: "=") != nil
    }
    
    func reduce() {
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            do { try elementMissing() }
            catch {
                printedString = "Missing Element"
                sendNotification(name: .receivedDataFromCountOnMe)
                printedString = ""
                return
            }
            do { try unknownOperator() }
            catch error {
                printedString = error.description
                return
            }
            
            let left = operationsToReduce[0]
            let operand = operationsToReduce[1]
            let right = operationsToReduce[2]
            
            
            guard let leftValue = Double(left) else {
                printedString = "Left operator not valid"
                sendNotification(name: "receivedDataFromCountOnMe")
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
            case "x": result = leftValue * rightValue
            case "÷": result = leftValue / rightValue
            default: fatalError("Unknown operator !")
            }
            
            do { try divisionError(leftValue, by: rightValue) }
            catch { printedString = "Not a number" }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result.clean)", at: 0)
            printedString.append(" = \(operationsToReduce.first!)")
            sendNotification(name: .receivedDataFromCountOnMe)
        }
    }

    func sendNotification(name: Notification.Name) {
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }

    func addNumber(_ numberText: String) {
        guard expressionHaveResult else { return }
        
        printedString = ""
        printedString.append(numberText)
        sendNotification(name:.receivedDataFromCountOnMe)
    }

    func plusButtonTapped() {
        guard canAddOperator else {
            sendNotification(name: "presentAlert")
            return
        }
        printedString.append(" + ")
        sendNotification(name: .receivedDataFromCountOnMe)
    }

    func minusButtonTapped() {
        guard canAddOperator else {
            sendNotification(name: "presentAlert")
            return
        }
        
        printedString.append(" - ")
        sendNotification(name: .receivedDataFromCountOnMe)
    }
    
    func multiplyButtonTapped() {
        guard canAddOperator else {
            sendNotification(name: "presentAlert")
            return
        }
            printedString.append(" x ")
            sendNotification(name: .receivedDataFromCountOnMe)
    }
    
    func divideButtonTapped() {
        guard canAddOperator else {
            sendNotification(name: "presentAlert")
            return
        }
        printedString.append(" ÷ ")
            sendNotification(name: .receivedDataFromCountOnMe)
        
    }
    
    func acButtonTapped() {
        // when the button is tapped so it sends data to the controller
        guard canAddOperator else {
            sendNotification(name: "presentAlert")
            return
        }
            printedString = "0"
            sendNotification(name: .receivedDataFromCountOnMe)
            printedString = ""
    }

    func equalButtonTapped() {
        guard expressionIsCorrect else {
            return sendNotification(name: "presentAlertForCorrectExpression")
        }
        guard expressionHaveEnoughElement else {
            return sendNotification(name: "presentAlertForElementNumber")
        }
    }
    
    func divisionError(_ left: Double, by right: Double) throws {
        guard right != 0 else {
            throw CalculatorError.zeroDivisor
        }
    }
    
    func elementMissing() throws {
        guard expressionHaveEnoughElement else {
            throw CalculatorError.missingElement
        }
    }
    
    func unknownOperator() throws {
        if elements.contains("+") || elements.contains("x") || elements.contains("÷") || elements.contains("-") {
            throw CalculatorError.unknowOperator
        }
    }
    
    enum Operator {
        case plus, minus, multiply, divide
        
        func asString() {
            switch self {
            case .plus: "+"
            case .divide: "÷"
            case .minus: "-"
            case .multiply: "x"
            }
        }
    }
    
    // priority for operations
}
