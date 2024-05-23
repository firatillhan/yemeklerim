//
//  TarifDetayVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import SDWebImage

class TarifDetayVC: UIViewController {
    
    var yemek:Yemekler?
    
    @IBOutlet weak var yemekResim: UIImageView!
    @IBOutlet weak var kullaniciFoto: UIImageView!
    @IBOutlet weak var kullaniciAd: UILabel!
    @IBOutlet weak var yemekKisiSayisi: UILabel!
    @IBOutlet weak var yemekHazirlikSuresi: UILabel!
    @IBOutlet weak var yemekPisirmeSuresi: UILabel!
    @IBOutlet weak var yemekAciklama: UILabel!
    @IBOutlet weak var yemekMalzemeler: UILabel!
    @IBOutlet weak var yemekTarif: UILabel!
    @IBOutlet weak var yemekAdLabel: UILabel!
    var yemekId = String()
    var gelenYemekId = String()
    var yemekAd = String()
    var kullanici = Auth.auth().currentUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if gelenYemekId != "" {
            favoriYemekDetay(yemekId: gelenYemekId)
        }
       
        if let y = yemek{
            navigationItem.title = "Kategori: \(y.kategori!)"
            
            yemekAdLabel.text = y.yemekAd // kategoriLabel ismi yemekAd olarak değiştirilecek
            yemekAd = y.yemekAd!
           
            yemekKisiSayisi.text = "\(y.yemekKisiSayisi!) Kişilik"
            yemekHazirlikSuresi.text = "Hazırlık: \(y.yemekHazirlikSuresi!)"
            yemekPisirmeSuresi.text = "Pişirme: \(y.yemekPisirmeSuresi!)"
            
            yemekAciklama.text = y.yemekAciklama
            yemekMalzemeler.text = y.yemekMalzemeler
            yemekTarif.text = y.yemekTarif
            kullaniciAd.text = y.kullaniciEmail
            yemekId = y.yemekId!
           // print("Seçilen  Yemek ID: \(yemekId)")
            if let resimUrl = y.yemekResim {
                yemekResim.sd_setImage(with: URL(string: resimUrl))
            }
        }
    }
    
    func favoriYemekDetay(yemekId:String){
        print(gelenYemekId)
        print("Yemek Id: \(gelenYemekId)")
       
 
            let db = Firestore.firestore()
        db.collection("yemekler").document(gelenYemekId).getDocument { [self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
              
                let kategoriAd = data?["kategori"] as? String ?? ""
                self.navigationItem.title = "Kategori: \(kategoriAd)"
                
                self.kullaniciAd.text = data?["kullaniciEmail"] as? String ?? ""
                self.yemekAciklama.text = data?["yemekAciklama"] as? String ?? ""
                yemekAd = data?["yemekAd"] as? String ?? ""
                self.yemekAdLabel.text = yemekAd
                self.yemekMalzemeler.text = data?["yemekMalzemeler"] as? String ?? ""
               
                self.yemekId = gelenYemekId //yemekId bilgisi çekilip değişkene aktarılıyor. ancak kullanıcı arayüzünde gösterilmeyecek.
                print("şuan gösterilen yemeğin id si\(yemekId)")
                
                
                self.yemekTarif.text = data?["yemekTarif"] as? String ?? ""
                
                let yemekHazirlik = data?["yemekHazirlikSuresi"] as? String ?? ""
                self.yemekHazirlikSuresi.text = "Hazırlık: \(yemekHazirlik)"
                
                
                let yemekKisi = data?["yemekKisiSayisi"] as? String ?? ""
                self.yemekKisiSayisi.text = "\(yemekKisi) Kişilik"
                
                
                let yemekPisirme = data?["yemekPisirmeSuresi"] as? String ?? ""
                self.yemekPisirmeSuresi.text = "Pişirme: \(yemekPisirme)"
                
                
                if let resimUrl = data?["yemekResim"] as! String? {
                    yemekResim.sd_setImage(with: URL(string: resimUrl))
                }

                
                
                
                
            }
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    @IBAction func deftereEkleButton(_ sender: Any) {
        begenilereEkle(kullaniciEmail: kullanici.email!, kullaniciUid: kullanici.uid, yemekId: yemekId,yemekAd:yemekAd)
       
        }
    
    func begenilereEkle(kullaniciEmail: String, kullaniciUid: String, yemekId: String, yemekAd: String) {
        let db = Firestore.firestore()
        
        // Belirli bir dökümanı kontrol etme
        let begenilerRef = db.collection("begeniler")
        let query = begenilerRef.whereField("kullaniciUid", isEqualTo: kullaniciUid).whereField("yemekId", isEqualTo: yemekId)
        
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription, button: "Tamam")
                return
            }
            
            if let documents = querySnapshot?.documents, !documents.isEmpty {
                // Kullanıcının bu yemeği daha önce favorilere eklediğini belirten hata mesajı
                self.makeAlert(titleInput: "Hata", messageInput: "Bu yemek zaten favorilerinizde mevcut.", button: "Tamam")
            } else {
                // Belge ekleme işlemi
                var ref: DocumentReference? = nil
                ref = begenilerRef.addDocument(data: [
                    "begeniId": ref?.documentID ?? UUID().uuidString,
                    "kullaniciEmail": kullaniciEmail,
                    "kullaniciUid": kullaniciUid,
                    "yemekId": yemekId,
                    "yemekAd": yemekAd,
                    "timestamp": FieldValue.serverTimestamp()
                ]) { error in
                    if let error = error {
                        self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription, button: "Tamam")
                    } else {
                        self.makeAlert(titleInput: "Tebrikler", messageInput: "Tarif deftere eklendi", button: "Tamam")
                    }
                }
            }
        }
    }



}
