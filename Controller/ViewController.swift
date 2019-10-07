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

    var countOnMe = CountOnMe()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let name = Notification.Name(rawValue: "receivedDataFromCountOnMe")
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(receiveDataFromCountOnMe), name: name, object: nil )
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        countOnMe.addNumber(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        countOnMe.plusButtonTapped()
        // present alert using the notification and check if condition in the model
        // todo : - make a function that calls the alert when an error occurs and the same for line 49-52
//        } else {
//            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
//            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            self.present(alertVC, animated: true, completion: nil)
//        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        countOnMe.minusButtonTapped()

        // present alert using the notification
//        } else {
//            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
//            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            self.present(alertVC, animated: true, completion: nil)
//        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard countOnMe.expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard countOnMe.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        countOnMe.reduce()
        textView.text = countOnMe.printedString
    }

    @objc func receiveDataFromCountOnMe() {
        textView.text = countOnMe.printedString
    }

    func presentAlert() {
        //create a notification for error and make it so that an alert is called 
        let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}

