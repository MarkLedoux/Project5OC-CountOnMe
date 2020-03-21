//
//  CalculatorViewControllerExtension.swift
//  CountOnMe
//
//  Created by Mark LEDOUX on 21/03/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

extension CalculatorViewController {
    func didUpdatePrintedString() {
        textView.text = calculator.printedString
    }
}
