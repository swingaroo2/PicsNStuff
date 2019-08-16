//
//  UIViewController+Extensions.swift
//  PicsNStuff
//
//  Created by Zach Lockett-Streiff on 8/16/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

// MARK: - AlertHelper
@objc extension UIViewController {
    func presentBasicAlert(message: String) {
        presentBasicAlert(title: nil, message: message)
    }
    
    func presentBasicAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
