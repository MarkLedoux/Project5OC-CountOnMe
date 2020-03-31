//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
	@IBOutlet weak var textView: UITextView!
	@IBOutlet var numberButtons: [UIButton]!

	private let calculator = Calculator()

	// View Life cycles
	override func viewDidLoad() {
		super.viewDidLoad()
		calculator.delegate = self
	}

	// MARK: Actions

	@IBAction func tappedNumberButton(_ sender: UIButton) {
		guard let numberText = sender.title(for: .normal) else {
			return
		}
		calculator.addNumber(numberText)
	}

	@IBAction func tappedAdditionButton(_ sender: UIButton) {
		calculator.add(mathOperator: .addition)
	}

	@IBAction func tappedSubstractionButton(_ sender: UIButton) {
		calculator.add(mathOperator: .substraction)
	}

	@IBAction func tappedMultiplyButton(_ sender: UIButton) {
		calculator.add(mathOperator: .multiplication)
	}

	@IBAction func tappedDivideButton(_ sender: UIButton) {
		calculator.add(mathOperator: .division)
	}

	@IBAction func tappedEqualButton(_ sender: UIButton) {
		calculator.reduce()
	}

	@IBAction func tappedACButton(_ sender: UIButton) {
		calculator.reset()
	}
}

extension CalculatorViewController: CalculatorDelegate {
	func didUpdatePrintedString() {
		textView.text = calculator.printedString
	}
}
