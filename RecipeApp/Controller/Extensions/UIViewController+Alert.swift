//
//  UIViewController+Alert.swift
//  travelApp
//
//  Created by Merouane Bellaha on 15/07/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

enum UserChoice {
    case doNothing, deleteFavorite
}

extension UIViewController {

    /// set an alert with a button "OK"
    func setAlertVc(with message: String) {
        let alertVC = UIAlertController(title: "Oups !", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true)
    }

    /// set an alert with an activity indicator and no button (to display when data are loading)
    func setActivityAlert(withTitle title: String, message: String, activityIndicatorColor: UIColor = UIColor.black, presentedActivityController: @escaping ((_ success: UIAlertController) -> Void)) {
        let alertController = UIAlertController(title: title, message: message + "\n\n\n", preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = activityIndicatorColor
        activityIndicator.startAnimating()
        alertController.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -8.0).isActive = true
        alertController.view.layoutIfNeeded()
        present(alertController, animated: true) { presentedActivityController(alertController) }
    }

    func setActionsAlert(title: String, message: String,
                         completion: @escaping (UserChoice) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { _ in completion(.deleteFavorite) })
        alert.addAction(UIAlertAction(title: "No", style: .default) { _ in completion(.doNothing) })
        self.present(alert, animated: true)
    }
}
