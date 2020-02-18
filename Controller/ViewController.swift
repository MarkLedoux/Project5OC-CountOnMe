//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(presentAlertForCorrectExpression),
            name: .presentAlertForCorrectExpression,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(presentAlertForElementNumber),
            name: .presentAlertForElementNumber,
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
        calculator.add(operand: " + ")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.add(operand: " - ")
    }
    
    @IBAction func tappedMultiplyButton(_ sender: UIButton) {
        calculator.add(operand: " × ")
    }
    
    @IBAction func tappedDivideButton(_ sender: UIButton) {
        calculator.add(operand: " ÷ ")
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

    private func presentSimpleAlert(title: String, message: String) {
        //create a notification for error and make it so that an alert is called
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @objc private func presentAlertForOperand() {
        presentSimpleAlert(title: "Zéro", message: "Un operateur est déja mis !")
    }

    @objc private func presentAlertForCorrectExpression() {
         presentSimpleAlert(title: "Zéro", message: "Entrez une expression correcte !")
    }

    @objc private func presentAlertForElementNumber() {
         presentSimpleAlert(title: "Zéro", message: "Démarrez un nouveau calcul !")
    }
}
