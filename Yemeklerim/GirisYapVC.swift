//
//  ViewController.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 23.04.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class GirisYapVC: UIViewController {

    @IBOutlet weak var userPasswordLabel: UITextField!
    @IBOutlet weak var userEmailLabel: UITextField!



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gestureRecognizerKlavye = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(gestureRecognizerKlavye)
    }
    @objc func hideKeyboard() {
               view.endEditing(true)
       }


    @IBAction func girisYapButton(_ sender: Any) {
        if userEmailLabel.text != "" && userPasswordLabel.text != nil {
            Auth.auth().signIn(withEmail: userEmailLabel.text!, password: userPasswordLabel.text!) { (authdata, error) in
                if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error", button: "Tamam")
                } else {
                    self.performSegue(withIdentifier: "tabBar", sender: nil)
                }
            }
        }else {
            makeAlert(titleInput: "Hata", messageInput: "Email/Şifre hata", button: "Tamam")
        }
    }
}

