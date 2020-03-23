//
//  CalculatorErrorPlusLocalizedError.swift
//  CountOnMe
//
//  Created by Mark LEDOUX  on 05/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

/// Enum with the cases of errors handled in the app
enum CalculatorError: Error {
	case zeroDivisor
	case missingElement
	case unknownOperator
	case leftOperatorNotValid
	case rightOperatorNotValid
}

extension CalculatorError: LocalizedError {
	/// Extension explaining what the program needs to return depending on the error return by the program
	public var errorDescription: String? {
		switch self {
		case .zeroDivisor:
			return NSLocalizedString("Not a number", comment: "")
		case .missingElement:
			return NSLocalizedString("Element missing", comment: "")
		case .unknownOperator:
			return NSLocalizedString("Unknown operator!", comment: "")
		case .leftOperatorNotValid:
			return NSLocalizedString("Left operator not valid", comment: "")
		case .rightOperatorNotValid:
			return NSLocalizedString("Right operator not valid", comment: "")
		}
	}
}
