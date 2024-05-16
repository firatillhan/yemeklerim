//
//  ViewController.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 23.04.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class GirisYapVC: UIViewController {

    @IBOutlet weak var userPasswordLabel: UITextField!
    @IBOutlet weak var userNameLabel: UITextField!
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
        performSegue(withIdentifier: "tabBar", sender: nil)
    }
}

