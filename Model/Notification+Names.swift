//
//  Notification.swift
//  CountOnMe
//
//  Created by Mark LEDOUX  on 05/02/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let receivedDataFromCountOnMe = Notification.Name("receivedDataFromCountOnMe")
    static let presentAlert = Notification.Name("presentAlert")
    static let presentAlertForCorrectExpression = Notification.Name("presentAlertForCorrectExpression")
    static let presentAlertForElementNumber = Notification.Name("presentAlertForElementNumber")
    static let presentAlertForOperand = Notification.Name("presentAlertForOperand")
}
