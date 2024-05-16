//
//  KayitOlVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class KayitOlVC: UIViewController {

    
    @IBOutlet weak var kullaniciAdLabel: UITextField!
    
    @IBOutlet weak var kullaniciEmailLabel: UITextField!
    
    
    @IBOutlet weak var kullaniciSifreLabel: UITextField!
    
    
    @IBOutlet weak var kullaniciSifreTekrarLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gestureRecognizerKlavye = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(gestureRecognizerKlavye)
    }
    @objc func hideKeyboard() {
               view.endEditing(true)
       }
    
    @IBAction func kayitOlButtonLabel(_ sender: Any) {
        
        if kullaniciSifreLabel.text != kullaniciSifreTekrarLabel.text {
            makeAlert(titleInput: "Hata", messageInput: "Şifreler Uyuşmuyor", button: "Tamam")
            return
        } else {
            if kullaniciAdLabel.text != "" && kullaniciEmailLabel.text != "" && kullaniciSifreLabel.text != "" &&  kullaniciSifreTekrarLabel.text != nil {
               
                Auth.auth().createUser(withEmail: kullaniciEmailLabel.text!, password: kullaniciSifreLabel.text!) { (authdata, error) in
                    if error != nil {
                        self.makeAlert(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Error", button: "Tamam")
                    } else {
                        self.makeAlert(titleInput: "Tebrikler", messageInput: "Kayıt oldunuz", button: "Tamam")
                        self.kullaniciEmailLabel.text = ""
                        self.kullaniciSifreLabel.text = ""
                        self.kullaniciSifreTekrarLabel.text = ""
                        self.kullaniciAdLabel.text = ""
                        
                    }
                }

            } else {
                print("hata")
                makeAlert(titleInput: "Hata", messageInput: "Email/Şifre hata", button: "Tamam")
            }
        }
    }
    

}
