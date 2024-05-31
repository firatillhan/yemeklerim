//
//  TarifGuncelleVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 23.05.2024.

//Not:  scrool view nesnesi eklenecek. 

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SDWebImage


class TarifGuncelleVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var yemekResim: UIImageView!
    @IBOutlet weak var yemekAd: UITextField!
    @IBOutlet weak var yemekAciklama: UITextField!
    @IBOutlet weak var yemekKisiSayisi: UITextField!
    @IBOutlet weak var yemekHazirlikSuresi: UITextField!
    @IBOutlet weak var yemekPisirmeSuresi: UITextField!
    @IBOutlet weak var yemekMalzemeler: UITextField!
    @IBOutlet weak var yemekTarif: UITextField!
    
    let kullanici = Auth.auth().currentUser!
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var gelenYemekId = String()
    var kullaniciEmail = String()
    var yemekId = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yemekGuncelle(yemekId: gelenYemekId)

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.title = "Tarif Güncelle"
        
        let gestureRecognizerKlavye = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(gestureRecognizerKlavye)
        
        yemekResim.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resimSec))
        yemekResim.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func yemekGuncelle(yemekId:String){
       
       

        let db = Firestore.firestore()
        db.collection("yemekler").document(gelenYemekId).getDocument { [self] (document, error) in
            
            if let document = document, document.exists {
        
                let data = document.data()
                
                self.yemekId = gelenYemekId //yemekId bilgisi çekilip değişkene aktarılıyor. ancak kullanıcı arayüzünde gösterilmeyecek.
                print("şuan gösterilen yemeğin id si\(self.yemekId)")
                self.yemekAd.text = data?["yemekAd"] as? String ?? ""
                self.yemekAciklama.text = data?["yemekAciklama"] as? String ?? ""
                self.yemekKisiSayisi.text = data?["yemekKisiSayisi"] as? String ?? ""
                self.yemekHazirlikSuresi.text = data?["yemekHazirlikSuresi"] as? String ?? ""
                self.yemekPisirmeSuresi.text = data?["yemekPisirmeSuresi"] as? String ?? ""
                self.yemekMalzemeler.text = data?["yemekMalzemeler"] as? String ?? ""
                self.yemekTarif.text = data?["yemekTarif"] as? String ?? ""
                
                if let resimUrl = data?["yemekResim"] as! String? {
                    yemekResim.sd_setImage(with: URL(string: resimUrl))
                }
            }
        }
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

    @IBAction func yemekGuncelleButton(_ sender: Any) {
        
        if yemekAd.text != "" && yemekAciklama.text != "" && yemekHazirlikSuresi.text != "" && yemekKisiSayisi.text != "" && 
            yemekMalzemeler.text != "" && yemekPisirmeSuresi.text != "" && yemekTarif.text != ""
             {
            
            let update: [String: Any] = [
                "yemekAd": yemekAd.text!,
                "yemekAciklama": yemekAciklama.text!,
                "yemekHazirlikSuresi": yemekHazirlikSuresi.text!,
                "yemekKisiSayisi": yemekKisiSayisi.text!,
                "yemekMalzemeler": yemekMalzemeler.text!,
                "yemekPisirmeSuresi": yemekPisirmeSuresi.text!,
                "yemekTarif": yemekTarif.text!,
            ]

            db.collection("yemekler").document(gelenYemekId).updateData(update) { error in
                if let error = error {
                    print("Error updating user data: \(error.localizedDescription)")
                } else {
                    self.makeAlert(titleInput: "Tebrikler", messageInput: "Tarifiniz Güncellendi", button: "TAMAM")
                }
            }
            
        } else {
            self.makeAlert(titleInput: "UYARI!", messageInput: "Lütfen boş alanları doldurunuz!", button: "TAMAM")
        }
        
        
    }
    
}
