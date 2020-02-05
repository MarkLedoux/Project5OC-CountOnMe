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

    let countOnMe = CountOnMe()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let name = Notification.Name(rawValue: "receivedDataFromCountOnMe")
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(receiveDataFromCountOnMe), name: name, object: nil )
    }
    
    // MARK: Actions
    
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        countOnMe.addNumber(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        countOnMe.plusButtonTapped()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        countOnMe.minusButtonTapped()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        countOnMe.equalButtonTapped()
        countOnMe.reduce()        
    }
    
    @IBAction func tappedMultiplyButton(_ sender: UIButton) {
        countOnMe.multiplyButtonTapped()
    }
    
    @IBAction func tappedDivideButton(_ sender: UIButton) {
        countOnMe.divideButtonTapped()
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        countOnMe.acButtonTapped()
    }
    
    
   
    
    // MARK: - @obj functions and other methods to present alerts to the user

    @objc func receiveDataFromCountOnMe() {
        textView.text = countOnMe.printedString
    }

    private func presentSimpleAlert(title: String, message: String) {
        //create a notification for error and make it so that an alert is called
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func presentAlertForAdditionSubstraction() {
        presentSimpleAlert(title: "Zéro", message: "Un operateur est déja mis !")
    }

    private func presentAlertForCorrectExpression() {
         presentSimpleAlert(title: "Zéro", message: "Entrez une expression correcte !")
    }

    private func presentAlertForElementNumber() {
         presentSimpleAlert(title: "Zéro", message: "Démarrez un nouveau calcul !")
    }

}
