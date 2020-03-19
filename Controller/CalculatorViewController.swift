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

    let calculator = Calculator()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(receiveDataFromCountOnMe),
            name: .receivedDataFromCountOnMe,
            object: nil
        )
    }

    // MARK: Actions

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addNumber(numberText)
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.add(operators: " + ")
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.add(operators: " - ")
    }

    @IBAction func tappedMultiplyButton(_ sender: UIButton) {
        calculator.add(operators: " × ")
    }

    @IBAction func tappedDivideButton(_ sender: UIButton) {
        calculator.add(operators: " ÷ ")
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.resolveEquation()
    }

    @IBAction func tappedACButton(_ sender: UIButton) {
        calculator.reset()
    }

    // MARK: - @obj functions and other methods to present alerts to the user

    @objc func receiveDataFromCountOnMe() {
        textView.text = calculator.printedString
    }
}
