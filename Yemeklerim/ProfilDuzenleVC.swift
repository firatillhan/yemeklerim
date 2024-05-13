//
//  ProfilDuzenleVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 30.04.2024.
//

import UIKit

class ProfilDuzenleVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var kullaniciAd: UILabel!
    @IBOutlet weak var kullaniciEmail: UILabel!
    @IBOutlet weak var kullaniciAdSoyad: UITextField!
    @IBOutlet weak var kullaniciAciklama: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
        imageView.layer.cornerRadius = CGRectGetWidth(self.imageView.frame) / 2

        
        let gestureRecognizerKlavye = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(gestureRecognizerKlavye)
        
    }
    @objc func hideKeyboard() {
               view.endEditing(true)
       }


}
