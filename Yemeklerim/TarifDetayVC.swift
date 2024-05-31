//
//  TarifDetayVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//
//Not: tarif sil butonuna basıldığında begeniler collection'undaki bütün yemekIdler kontrol edilip silinmesi gerekli. şimdilik sadece 1 tanesi siliniyor. döngü kullan.


import UIKit
import FirebaseFirestore
import FirebaseAuth
import SDWebImage

class TarifDetayVC: UIViewController {
    
    
    
    @IBOutlet weak var yemekResim: UIImageView!
    @IBOutlet weak var kullaniciAd: UILabel!
    @IBOutlet weak var yemekKisiSayisi: UILabel!
    @IBOutlet weak var yemekHazirlikSuresi: UILabel!
    @IBOutlet weak var yemekPisirmeSuresi: UILabel!
    @IBOutlet weak var yemekAciklama: UILabel!
    @IBOutlet weak var yemekMalzemeler: UILabel!
    @IBOutlet weak var yemekTarif: UILabel!
    @IBOutlet weak var yemekAdLabel: UILabel!
    
    var yemek:Yemekler?
    var favori:Favoriler?
    
    var yemekId = String()
    var kullanici = Auth.auth().currentUser!
    var favYemekId = String()
  
    let db = Firestore.firestore()
    
    @IBOutlet weak var tarifDuzenleButtonLabel: UIBarButtonItem!
    @IBOutlet weak var tarifSilButtonLabel: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let y = yemek {
            yemekId = y.yemekId //yemek sil için
            navigationItem.title = "Kategori: \(y.kategori)"
            kullaniciAd.text = y.kullaniciAd
            let kullaniciUid = y.kullaniciUid
            yemekAciklama.text = y.yemekAciklama
            yemekAdLabel.text = y.yemekAd
            yemekHazirlikSuresi.text = "Hazırlık: \(y.yemekHazirlikSuresi)"
            yemekKisiSayisi.text = "\(y.yemekKisiSayisi) Kişilik"
            yemekMalzemeler.text = y.yemekMalzemeler
            yemekPisirmeSuresi.text = "Pişirme: \(y.yemekPisirmeSuresi)"
            yemekResim.sd_setImage(with: URL(string: y.yemekResim))
            yemekTarif.text = y.yemekTarif

            if kullaniciUid == kullanici.uid {
                tarifDuzenleButtonLabel.isHidden = false
                tarifSilButtonLabel.isHidden = false
            } else {
                tarifDuzenleButtonLabel.isHidden = true
                tarifSilButtonLabel.isHidden = true
            }
        }
        
        if let f = favori {
            yemekId = f.yemekId
            print("yemekId: \(yemekId)")
            yemekleriCek(yemekId: yemekId)
            
        }
        
        
      

       
        
        
    }
    
    func yemekleriCek(yemekId:String){
        
        db.collection("yemekler").document(yemekId).getDocument { [self] document, error in
         
            if let document = document, document.exists {
                let group = DispatchGroup()
                let data = document.data()
                let kategori = data?["kategori"] as? String ?? ""
                navigationController?.navigationBar.topItem?.title = "Kategori: \(kategori)"
                let kullaniciUid = data?["kullaniciUid"] as? String ?? "kullanici Uid"
                yemekAdLabel.text = data?["yemekAd"] as? String ?? "yemek Ad"
                yemekAciklama.text = data?["yemekAciklama"] as? String ?? ""
                let yemekHazirlikSuresi = data?["yemekHazirlikSuresi"] as? String ?? ""
                self.yemekHazirlikSuresi.text = "Hazırlık: \(yemekHazirlikSuresi)"
                let yemekKisiSayisi = data?["yemekKisiSayisi"] as? String ?? ""
                self.yemekKisiSayisi.text = "\(yemekKisiSayisi) Kişilik"
                yemekMalzemeler.text = data?["yemekMalzemeler"] as? String ?? ""
                let yemekPisirmeSuresi = data?["yemekPisirmeSuresi"] as? String ?? ""
                self.yemekPisirmeSuresi.text = "Pişirme: \(yemekPisirmeSuresi)"
                yemekTarif.text = data?["yemekTarif"] as? String ?? ""
                
                if kullaniciUid == kullanici.uid {
                    self.tarifDuzenleButtonLabel.isHidden = false
                    self.tarifSilButtonLabel.isHidden = false
                } else {
                    self.tarifDuzenleButtonLabel.isHidden = true
                    self.tarifSilButtonLabel.isHidden = true
                }
                
                if let yemekResim = document.data()?["yemekResim"] as? String,
                    let url = URL(string: yemekResim) {
                    self.yemekResim.sd_setImage(with: url, completed: nil)
                }
                group.enter()
                self.db.collection("kullanicilar").document(kullaniciUid).getDocument { document, error in
                    if let error = error {
                        print("Hata \(error)")
                    }else {
                        if let document = document {
                            let data = document.data()
                            self.kullaniciAd.text = data?["kullaniciAd"] as? String ?? "kullaniciAd"
                        }
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    func begenilereEkle(kullaniciUid: String, yemekId: String) {
        print("kullanici uid: \(kullaniciUid)")
        print("yemekId: \(yemekId)")

       
        // Belirli bir dökümanı kontrol etme
        let begenilerRef = db.collection("begeniler")
        let query = begenilerRef.whereField("kullaniciUid", isEqualTo:kullaniciUid).whereField("yemekId", isEqualTo: yemekId)
        
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription, button: "Tamam")
                return
            }
            
            if let documents = querySnapshot?.documents, !documents.isEmpty {
                // Kullanıcının bu yemeği daha önce favorilere eklediğini belirten hata mesajı
                self.makeAlert(titleInput: "Hata", messageInput: "Bu yemek zaten favorilerinizde mevcut.", button: "Tamam")
            } else {
                if kullaniciUid != "" && yemekId != ""{
                    let begeniEkle: [String:Any] = [
                        "begeniId": "",
                        "kullaniciUid": kullaniciUid,
                        "yemekId": self.yemekId,
                        "timestamp": FieldValue.serverTimestamp()
                    ]
                    let database = Firestore.firestore()
                    database.collection("begeniler").addDocument(data: begeniEkle) { error in
                        if let error = error {
                            print("Error \(error)")
                        } else {
                            self.makeAlert(titleInput: "Tebrikler", messageInput: "Tarif başarılı bir şekilde listenize eklendi", button: "TAMAM")
                        }
                    }
                } else {
                    self.makeAlert(titleInput: "Hata", messageInput: "Bilinmeyen bir hata oluştu", button: "TAMAM")
                }
            }
        }
    }
    
    



    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTarifGuncelle" {
            if let destinationVC = segue.destination as? TarifGuncelleVC {
                destinationVC.gelenYemekId = self.yemekId
            }
        }
    }
    
    
    @IBAction func tarifDuzenleButton(_ sender: Any) {
        performSegue(withIdentifier: "toTarifGuncelleVC", sender: nil)
    }
    
    @IBAction func deftereEkleButton(_ sender: Any) {
        begenilereEkle(kullaniciUid: kullanici.uid, yemekId: yemekId)
    }
    
    
    
    
    
    @IBAction func tarifSilButton(_ sender: Any) {
        print("silinecek yemek ıd : \(yemekId)")
        deleteYemekAndBegeniler(yemekId: yemekId)
    }
}





extension TarifDetayVC {
    func deleteYemekAndBegeniler(yemekId: String) {
        
        let db = Firestore.firestore()
        
        db.collection("yemekler").document(yemekId).delete { error in
            if let error = error {
                self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription, button: "TAMAM")
                return
            } else {
                print("yemek silindi")
                self.tabBarController?.selectedIndex = 0
            }
        }
        
        db.collection("begeniler").whereField("yemekId", isEqualTo: yemekId).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let document = querySnapshot?.documents.first {
                    print("Document ID: \(document.documentID)")
                    
                    db.collection("begeniler").document(document.documentID).delete { error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            print("begenilerden silindi")
                            self.tabBarController?.selectedIndex = 0

                        }
                    }
                    
                } else {
                    print("No document found with yemekId: \(yemekId)")
                }
            }
        }
        }// fonk bitiş
    
    

}
