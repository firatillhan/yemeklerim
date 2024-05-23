//
//  ProfilDuzenleVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 30.04.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfilDuzenleVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var kullaniciResim: UIImageView!
    @IBOutlet weak var kullaniciAd: UITextField!
  
    @IBOutlet weak var kullaniciAdSoyad: UITextField!
    @IBOutlet weak var kullaniciAciklama: UITextField!
    
    let kullanici = Auth.auth().currentUser!
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.title = "Profilini Düzenle"

        GetUserData()
        kullaniciResim.layer.cornerRadius = kullaniciResim.frame.width / 2
        kullaniciResim.clipsToBounds = true
  //      kullaniciResim.layer.cornerRadius = CGRectGetWidth(self.kullaniciResim.frame) / 2

        
        let gestureRecognizerKlavye = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(gestureRecognizerKlavye)
        
        kullaniciResim.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resimSec))
        kullaniciResim.addGestureRecognizer(gestureRecognizer)
        

        
    }
    
    @objc func resimSec() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        kullaniciResim.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    
    @objc func hideKeyboard() {
               view.endEditing(true)
       }

    
    func GetUserData(){
        guard let uid = Auth.auth().currentUser?.uid else { return }

        db.collection("kullanicilar").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                self.navigationController?.navigationBar.topItem?.title = data?["kullaniciAd"] as? String ?? "no name"
                self.kullaniciAdSoyad.text = data?["kullaniciAdSoyad"] as? String ?? "No Name surname"
                self.kullaniciAd.text = data?["kullaniciAd"] as? String ?? "  "
                self.kullaniciAciklama.text = data?["kullaniciAciklama"] as? String ?? "  "
                if let imageURL = data?["kullaniciResim"] as? String, let url = URL(string: imageURL) {
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        if let data = data, error == nil {
                            DispatchQueue.main.async {
                                self.kullaniciResim.image = UIImage(data: data)
                            }
                        }
                    }.resume()
                }
            } else {
                print("Document does not exist")
            }
        }
    }

    
    @IBAction func resmiKaydet(_ sender: Any) {
       
        guard let uid = Auth.auth().currentUser?.uid else { return }
                let storageReference = storage.reference()
                let mediaFolder = storageReference.child("kullaniciResimler")

                if let data = kullaniciResim.image?.jpegData(compressionQuality: 0.75) {
                    let imageReference = mediaFolder.child("\(uid).jpg")
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpeg"

                    imageReference.putData(data, metadata: metadata) { metadata, error in
                        if let error = error {
                            print("Error uploading image: \(error.localizedDescription)")
                            return
                        }
                        imageReference.downloadURL { url, error in
                            if let error = error {
                                print("Error getting download URL: \(error.localizedDescription)")
                                return
                            }
                            if let imageURL = url?.absoluteString {
                                guard let uid = Auth.auth().currentUser?.uid else { return }

                                self.db.collection("kullanicilar").document(uid).updateData([
                                    "kullaniciResim": imageURL
                                ]) { error in
                                    if let error = error {
                                        print("Error saving image URL to Firestore: \(error.localizedDescription)")
                                    } else {
                                        self.makeAlert(titleInput: "Tebrikler", messageInput: "Profil resminiz güncellendi", button: "Tamam")
                                    }
                                }
                            }
                        }
                    }
                }
        
    }
    
    @IBAction func profilKaydet(_ sender: Any) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
             guard let kullaniciAdSoyad = kullaniciAdSoyad.text, !kullaniciAdSoyad.isEmpty,
                   let kullaniciAd = kullaniciAd.text, !kullaniciAd.isEmpty,
                   let kullaniciAciklama = kullaniciAciklama.text, !kullaniciAciklama.isEmpty else {
                 print("Please fill in all fields")
                 return
             }

             let userData: [String: Any] = [
                 "kullaniciAdSoyad": kullaniciAdSoyad,
                 "kullaniciAd": kullaniciAd,
                 "kullaniciAciklama": kullaniciAciklama
             ]

             db.collection("kullanicilar").document(uid).updateData(userData) { error in
                 if let error = error {
                     print("Error updating user data: \(error.localizedDescription)")
                 } else {
                     self.makeAlert(titleInput: "Tebrikler", messageInput: "Profiliniz Güncellendi", button: "Tamam")
                 }
             }
        
        
    
    }
    
    
    
}
