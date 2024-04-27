//
//  TarifYukleVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit

class TarifYukleVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var yemekAd: UITextField!
    @IBOutlet weak var yemekAciklama: UITextField!
    @IBOutlet weak var yemekKisiSayisi: UITextField!
    @IBOutlet weak var yemekResim: UIImageView!
    @IBOutlet weak var yemekHazirlikSuresi: UITextField!
    @IBOutlet weak var yemekPisirmeSuresi: UITextField!
    @IBOutlet weak var yemekMalzemeler: UITextField!
    @IBOutlet weak var kategoriSec: UITextField!
    @IBOutlet weak var yemekTarif: UITextField!
    
    var pickerView:UIPickerView?
    var kategorilerim:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self
        kategorilerim = [ "Kahvaltılıklar","Çorbalar","Salatalar","Ana Yemekler","Makarnalar","Pilavlar","Izgaralar","Deniz Ürünleri","Vejeteryan Yemekler","Tatlılar"]
        kategoriSec.inputView = pickerView
        let toolbar = UIToolbar()
        toolbar.tintColor = UIColor.red
        toolbar.sizeToFit()
        let iptalButton = UIBarButtonItem(title: "İptal", style: .plain, target: self, action: #selector(self.iptalTikla))
        let boslukButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let tamamButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(self.tamamTikla))

        toolbar.setItems([iptalButton,boslukButton,tamamButton], animated: true)
        kategoriSec.inputAccessoryView = toolbar
        let gestureRecognizerKlavye = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(gestureRecognizerKlavye)
        
    }
    @objc func hideKeyboard() {
               view.endEditing(true)
       }
    @objc func tamamTikla(){
        view.endEditing(true)
    }
    
    @objc func iptalTikla(){
        kategoriSec.text = ""
        kategoriSec.placeholder = "KategoriSeç"
        view.endEditing(true)
    }
    
    @IBAction func tarifYukleButton(_ sender: Any) {
        if kategoriSec.text != "" {
            self.makeAlert(titleInput: "Tebrikler", messageInput: "Tarifiniz yüklendi", button: "TAMAM")
        } else {
            self.makeAlert(titleInput: "Hata", messageInput: "Zorunlu alanları doldurunuz!!", button: "Tamam")
        }
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kategorilerim.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return kategorilerim[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        kategoriSec.text = kategorilerim[row]
    }
}



