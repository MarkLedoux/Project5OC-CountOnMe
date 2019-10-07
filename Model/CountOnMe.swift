//
//  CountOnMe.swift
//  CountOnMe
//
//  Created by Mark LEDOUX on 20/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class CountOnMe {

    var printedString: String = "1 + 1 = 2"

    var elements: [String] {
           return printedString.split(separator: " ").map { "\($0)" }
       }

       // Error check computed variables
       var expressionIsCorrect: Bool {
           return elements.last != "+" && elements.last != "-"
       }

       var expressionHaveEnoughElement: Bool {
           return elements.count >= 3
       }

       var canAddOperator: Bool {
           return elements.last != "+" && elements.last != "-"
       }

       var expressionHaveResult: Bool {
           return printedString.firstIndex(of: "=") != nil
       }

    func reduce() {

        // Create local copy of operations
        var operationsToReduce = elements

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!

            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
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
        }
    }

    func minusButtonTapped() {
        if canAddOperator {
        printedString.append(" - ")
        sendNotification(name: "receivedDataFromCoutOnMe")
        }
    }
    
}
