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

    
    @IBOutlet weak var kullaniciEmailLabel: UITextField!
    @IBOutlet weak var kullaniciSifreLabel: UITextField!
    @IBOutlet weak var kullaniciSifreTekrarLabel: UITextField!
    
    let db = Firestore.firestore()

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
            guard let kullaniciEmail = kullaniciEmailLabel.text, !kullaniciEmail.isEmpty,
                  let kullaniciSifre = kullaniciSifreLabel.text, !kullaniciSifre.isEmpty,
                  let kullaniciSifreTekrar = kullaniciSifreTekrarLabel.text, !kullaniciSifreTekrar.isEmpty
                else {
                print("Lütfen bütün alanları doldurunuz!")
                return
            }
            
            Auth.auth().createUser(withEmail: kullaniciEmail, password: kullaniciSifre) { authResult, error in
                if let error = error {
                    print("Error creating user: \(error.localizedDescription)")
                    return
                }
                guard let uid = authResult?.user.uid else { return }

                self.db.collection("kullanicilar").document(uid).setData([
                    "kullaniciAd": "",
                    "kullaniciAdSoyad": "",
                    "kullaniciEmail": kullaniciEmail,
                    "kullaniciAciklama": "",
                    "kullaniciResim": "" // Resim alanı başlangıçta boş bir string
                ]) { error in
                    if let error = error {
                        print("Error adding user data to Firestore: \(error.localizedDescription)")
                    } else {
                        print("User data added to Firestore")
                        self.makeAlert(titleInput: "Tebrikler", messageInput: "Kayıt işleminiz tamamlanmıştır.", button: "TAMAM")
                    }
                }
            }
            
            
            
      
        }
    }
    

}
