//
//  CalculatorDelegate.swift
//  CountOnMe
//
//  Created by Mark LEDOUX on 21/03/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

/*
Delegation is a design pattern that enables a class or structure to hand off (or delegate)
some of its responsibilities to an instance of another type.
This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities,
such that a conforming type (known as a delegate) is guaranteed to provide the functionality that has been delegated.
Delegation can be used to respond to a particular action,
or to retrieve data from an external source without needing to know the underlying type of that source.
*/
protocol CalculatorDelegate: AnyObject {
	func didUpdatePrintedString()
}
