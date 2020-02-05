//
//  Operator.swift
//  CountOnMe
//
//  Created by Mark LEDOUX  on 05/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

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
