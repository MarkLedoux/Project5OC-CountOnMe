//
//  CalculatorErrorPlusLocalizedError.swift
//  CountOnMe
//
//  Created by Mark LEDOUX  on 05/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

// Enum with the cases of errors handled in the app
enum CalculatorError: Error {
    case zeroDivisor
    case missingElement
    case unknowOperator
}

// Extension explaining what the program needs to return depending on the error return by the program
extension CalculatorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .zeroDivisor:
            return NSLocalizedString("Not a number", comment: "")
        case .missingElement:
            return NSLocalizedString("Element missing", comment: "")
        case .unknowOperator:
            return NSLocalizedString("Unknow operator!", comment: "")
        }
    }
}
