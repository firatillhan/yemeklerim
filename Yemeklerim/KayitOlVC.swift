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

    @IBOutlet weak var kullaniciAd: UITextField!
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
            guard let kullaniciAd = kullaniciAd.text, !kullaniciAd.isEmpty,
                  let kullaniciEmail = kullaniciEmailLabel.text, !kullaniciEmail.isEmpty,
                  let kullaniciSifre = kullaniciSifreLabel.text, !kullaniciSifre.isEmpty,
                  let kullaniciSifreTekrar = kullaniciSifreTekrarLabel.text, !kullaniciSifreTekrar.isEmpty
                else {
                self.makeAlert(titleInput: "Hata", messageInput: "Lütfen Bütün alanları doldurunuz!!!", button: "TAMAM")
                return
            }
            
            let kullaniciRef = db.collection("kullanicilar")
            let sorgu = kullaniciRef.whereField("kullaniciAd", isEqualTo: kullaniciAd)
            sorgu.getDocuments { (sorguSnap, error) in
                if let error = error {
                    self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription, button: "TAMAM")
                    return
                }
                if let documents = sorguSnap?.documents, !documents.isEmpty {
                    self.makeAlert(titleInput: "Hata", messageInput: "Bu kullanıcı adı daha önce alınmış!", button: "TAMAM")
                } else {
                    
                    Auth.auth().createUser(withEmail: kullaniciEmail, password: kullaniciSifre) { authResult, error in
                        if let error = error {
                            self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription, button: "TAMAM")
                            return
                        }
                        guard let uid = authResult?.user.uid else { return }

                        self.db.collection("kullanicilar").document(uid).setData([
                            "kullaniciAd": kullaniciAd,
                            "kullaniciAdSoyad": "",
                            "kullaniciEmail": kullaniciEmail,
                            "kullaniciAciklama": "",
                            "kullaniciResim": ""
                        ]) { error in
                            if let error = error {
                                self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription, button: "TAMAM")
                            } else {
                              
                                self.makeAlert(titleInput: "Tebrikler", messageInput: "Kayıt işleminiz tamamlanmıştır.", button: "TAMAM")
                                self.performSegue(withIdentifier: "tabBar", sender: nil)
                        
                            }
                        }
                    }

                }
            }
        }
    }
}
