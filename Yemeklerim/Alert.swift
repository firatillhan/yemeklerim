//
//  Alert.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import Foundation
import UIKit

extension UIViewController {
    func makeAlert(titleInput:String,messageInput:String,button:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: button, style: .default, handler: nil)
        alert.addAction(button)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
