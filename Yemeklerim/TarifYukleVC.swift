//
//  TarifYukleVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class TarifYukleVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    var kategoriListesi = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self
        kategoriListesi = [ "Kahvaltılıklar","Çorbalar","Salatalar","Ana Yemekler","Et Yemekleri","Tavuk Yemekleri","Makarnalar","Pilavlar","Izgaralar","Deniz Ürünleri","Vejeteryan Yemekler","Tatlılar","İçecekler"]
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
        
        yemekResim.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resimSec))
        yemekResim.addGestureRecognizer(gestureRecognizer)
        
    }
    @objc func resimSec() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
  
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        yemekResim.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
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
        
     
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("yemekResimMedia")
        
        if let data = yemekResim.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data,metadata: nil){ (metadata,error) in
                if error != nil {
                    self.makeAlert(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Bilinmeyen hata", button: "TAMAM")
                } else { //else başlangıç
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let yemekUrl = url?.absoluteString
                            let firestoreDatabase = Firestore.firestore()
                            let yemekKaydet = [ "yemekTarih": FieldValue.serverTimestamp(),
                                                "yemekResim": yemekUrl!,
                                                "yemekId": "",
                                                "yemekAd": self.yemekAd.text!,
                                                "yemekKisiSayisi": self.yemekKisiSayisi.text!,
                                                "yemekAciklama":self.yemekAciklama.text!,
                                                "yemekHazirlikSuresi": self.yemekHazirlikSuresi.text!,
                                                "yemekTarif": self.yemekTarif.text!,
                                                "yemekPisirmeSuresi": self.yemekPisirmeSuresi.text!,
                                                "yemekMalzemeler" : self.yemekMalzemeler.text!,
                                                "kategori" : self.kategoriSec.text!,
                                                "kullaniciEmail": Auth.auth().currentUser!.email!,
                                                "kullaniciUid": Auth.auth().currentUser!.uid] as [String : Any]
                            
                            var firestoreReference : DocumentReference? = nil
                                firestoreReference = firestoreDatabase.collection("yemekler").addDocument(data: yemekKaydet, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Hata!", button: "TAMAM")
                                } else {
                                    self.yemekResim.image = UIImage(named: "select")
                                    self.yemekAd.text = ""
                                    self.yemekKisiSayisi.text = ""
                                    self.yemekKisiSayisi.text = ""
                                    self.yemekHazirlikSuresi.text = ""
                                    self.yemekTarif.text = ""
                                    self.yemekPisirmeSuresi.text = ""
                                    self.yemekMalzemeler.text = ""
                                    self.yemekAciklama.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                        }
                    }
                }
            } //else bitiş
        }
        
        
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kategoriListesi.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return kategoriListesi[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        kategoriSec.text = kategoriListesi[row]
    }
}



