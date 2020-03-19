//
//  Operators.swift
//  CountOnMe
//
//  Created by Mark LEDOUX  on 18/03/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum Operators: CaseIterable {
    case substraction
    case addition
    case division
    case multiplication
}

extension Operators {
    /// Extension explaining what the program needs to return depending on the error return by the program
    public var operatorDescription: String? {
        switch self {
        case .substraction:
            return NSLocalizedString("-", comment: "")
        case .addition:
            return NSLocalizedString("+", comment: "")
        case .division:
            return NSLocalizedString("÷", comment: "")
        case .multiplication:
            return NSLocalizedString("×", comment: "")
        }
    }
}
