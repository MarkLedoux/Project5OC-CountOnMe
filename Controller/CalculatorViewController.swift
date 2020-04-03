//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class CalculatorViewController: UIViewController {
	@IBOutlet private weak var textView: UITextView!

	private let calculator = Calculator()

	// View Life cycles
	override func viewDidLoad() {
		super.viewDidLoad()
		calculator.delegate = self
	}

	// MARK: Actions

	@IBAction private func tappedNumberButton(_ sender: UIButton) {
		guard let numberText = sender.title(for: .normal) else {
			return
		}
		calculator.addNumber(numberText)
	}

    // une seule action pour tous les boutons? 
	@IBAction private func tappedAdditionButton(_ sender: UIButton) {
		calculator.add(mathOperator: .addition)
	}

	@IBAction private func tappedSubstractionButton(_ sender: UIButton) {
		calculator.add(mathOperator: .substraction)
	}

	@IBAction private func tappedMultiplyButton(_ sender: UIButton) {
		calculator.add(mathOperator: .multiplication)
	}

	@IBAction private func tappedDivideButton(_ sender: UIButton) {
		calculator.add(mathOperator: .division)
	}

	@IBAction private func tappedEqualButton(_ sender: UIButton) {
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
