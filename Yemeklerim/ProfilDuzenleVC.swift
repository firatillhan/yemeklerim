//
//  ProfilDuzenleVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 30.04.2024.
//

import UIKit

class ProfilDuzenleVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var kullaniciAd: UITextField!
    @IBOutlet weak var kullaniciAdSoyad: UITextField!
    @IBOutlet weak var kullaniciAciklama: UITextField!
    @IBOutlet weak var kullaniciEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        kullaniciAd.isEnabled
        kullaniciEmail.isEnabled
        
        let gestureRecognizerKlavye = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(gestureRecognizerKlavye)
        
    }
    @objc func hideKeyboard() {
               view.endEditing(true)
       }


}
