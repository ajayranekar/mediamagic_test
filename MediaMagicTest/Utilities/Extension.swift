//
//  Extension.swift
//  MediaMagicTest
//
//  Created by Ajay Ranekar on 01/06/20.
//  Copyright © 2020 Ajay Ranekar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Plain alert
    func alert(message: String) -> Void {
        let alert = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: Constants.OK, style: .default, handler: nil))
        alert.present(alert, animated: true, completion: nil)
    }
    
}
