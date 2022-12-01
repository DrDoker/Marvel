//
//  UIViewController + Ext.swift
//  Marvel
//
//  Created by Serhii  on 01/12/2022.
//

import UIKit

extension UIViewController {
	func showAlert(withTitle title: String, andMessage message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let actionOK = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(actionOK)
		present(alert, animated: true)
	}
}
