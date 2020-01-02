//
//  CountOnMe.swift
//  CountOnMe
//
//  Created by Mark LEDOUX on 20/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

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
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!
            
            let result: Float
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "÷": result = left / right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result.clean)", at: 0)
            printedString.append(" = \(operationsToReduce.first!)")
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
    
    // when a division by 0 is made, make an error that send a message to the calculator saying the operation is not possible
    
    // when tapping a number and the and operand, do the same as the calculator and calculate as if the second number was the same
    
    // make a test when tapping two operands in a row, cancel the first one that was tapped and only take into account the second one 
}
