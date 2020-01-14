//
//  CountOnMe.swift
//  CountOnMe
//
//  Created by Mark LEDOUX on 20/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

private enum CalculatorError: Error {
    case zeroDivisor
    case missingElement
    case unknowOperator
}

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

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
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
                sendNotification(name: "receivedDataFromCountOnMe")
                printedString = ""
                return
            }
            do { try unknownOperator() }
            catch {
                printedString = "Unknown operator!"
                return
            }
            
            let left = operationsToReduce[0]
            let operand = operationsToReduce[1]
            let right = operationsToReduce[2]
            
            
            guard let leftValue = Float(left) else {
                printedString = "Left operator not valid"
                sendNotification(name: "receivedDataFromCountOnMe")
//                printedString = ""
                return
            }
            
            guard let rightValue = Float(right) else {
                printedString = "Right operator not valid"
                sendNotification(name: "receivedDataFromCountOnMe")
//                printedString = ""
                return
            }
            
            
            let result: Float
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
            sendNotification(name: "receivedDataFromCountOnMe")
        }
    }

    private func sendNotification(name: String) {
        let name = Notification.Name(rawValue: name)
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }

    func addNumber(_ numberText: String) {
        if expressionHaveResult {
            printedString = ""
        }
        printedString.append(numberText)
        sendNotification(name:"receivedDataFromCountOnMe")
    }

    func plusButtonTapped() {
        if canAddOperator {
            printedString.append(" + ")
            sendNotification(name: "receivedDataFromCountOnMe")
        } else {
            sendNotification(name: "presentAlert")
        }
    }

    func minusButtonTapped() {
        if canAddOperator {
            printedString.append(" - ")
            sendNotification(name: "receivedDataFromCoutOnMe")
        } else {
            sendNotification(name: "presentAlert")
        }
    }
    
    func multiplyButtonTapped() {
        if canAddOperator {
            printedString.append(" x ")
            sendNotification(name: "receivedDataFromCountOnMe")
        } else {
            sendNotification(name: "presentAlert")
        }
    }
    
    func divideButtonTapped() {
        if canAddOperator {
            printedString.append(" ÷ ")
            sendNotification(name: "receivedDataFromCountOnMe")
        } else {
            sendNotification(name: "presentAlert")
        }
        
    }
    
    func acButtonTapped() {
        // when the button is tapped so it sends data to the controller
        if canAddOperator {
            printedString = "0"
            sendNotification(name: "receivedDataFromCountOnMe")
            printedString = ""
        } else {
            sendNotification(name: "presentAlert")
        }
    }

    func equalButtonTapped() {
        guard expressionIsCorrect else {
            return sendNotification(name: "presentAlertForCorrectExpression")
        }
        guard expressionHaveEnoughElement else {
            return sendNotification(name: "presentAlertForElementNumber")
        }
    }
    
    func divisionError(_ left: Float, by right: Float) throws {
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
        guard elements.contains("+")  || elements.contains("x") || elements.contains("÷") || elements.contains("-") else {
            throw CalculatorError.unknowOperator
        }
    }
    
    // look where to put printedstring in order to properly shows the errors on screen and unit tests
    
    // priority for operations
}
