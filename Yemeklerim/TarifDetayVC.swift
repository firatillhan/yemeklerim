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
    
    var kullaniciAdCek = String()
    
    @IBOutlet weak var yemekResim: UIImageView!
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
    var gelenKullaniciAdi = String()
    var kullaniciUid = String()
    let db = Firestore.firestore()
    
    @IBOutlet weak var tarifDuzenleButtonLabel: UIBarButtonItem!
    @IBOutlet weak var tarifSilButtonLabel: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       kullaniciCek()

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
            gelenKullaniciAdi = y.kullaniciAd!
            kullaniciAd.text = gelenKullaniciAdi
            kullaniciUid = y.kullaniciUid!
            
            if kullaniciUid == kullanici.uid {
                tarifDuzenleButtonLabel.isHidden = false
                tarifSilButtonLabel.isHidden = false
            } else {
                tarifDuzenleButtonLabel.isHidden = true
                tarifSilButtonLabel.isHidden = true
            }
            
            
            
            yemekId = y.yemekId!
         
            if let resimUrl = y.yemekResim {
                yemekResim.sd_setImage(with: URL(string: resimUrl))
            }
        }
    }
    func kullaniciCek(){
        db.collection("kullanicilar").document(kullanici.uid).getDocument { document, error in
         
            if let document = document, document.exists {
                let data = document.data()
                self.kullaniciAdCek = data?["kullaniciAd"] as? String ?? ""
                print("kullancıcı ad: \(self.kullaniciAdCek)")
            } else {
                print("Hata")
            }
        }
        
    }
    func favoriYemekDetay(yemekId:String){
        
        if kullaniciUid == kullanici.uid {
            tarifDuzenleButtonLabel.isHidden = false
            tarifSilButtonLabel.isHidden = false
        } else {
            tarifDuzenleButtonLabel.isHidden = true
            tarifSilButtonLabel.isHidden = true
        }
        
        db.collection("yemekler").document(gelenYemekId).getDocument { [self] (document, error) in
            
            if let document = document, document.exists {
        
                let data = document.data()
                let kategoriAd = data?["kategori"] as? String ?? ""
                self.navigationItem.title = "Kategori: \(kategoriAd)"
                gelenKullaniciAdi = data?["kullaniciAd"] as? String ?? ""
                self.kullaniciAd.text = gelenKullaniciAdi
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTarifGuncelle" {
            if let destinationVC = segue.destination as? TarifGuncelleVC {
                //let indeks = sender as? Int
                destinationVC.gelenYemekId = self.yemekId
            }
        }
    }
    
    
    @IBAction func tarifDuzenleButton(_ sender: Any) {
       performSegue(withIdentifier: "toTarifGuncelleVC", sender: nil)
        
    }
    
    @IBAction func deftereEkleButton(_ sender: Any) {
        
        begenilereEkle(kullaniciAdCek: kullaniciAdCek, kullaniciUid: kullanici.uid, yemekId: yemekId,yemekAd:yemekAd)
       
        }
    
    func begenilereEkle(kullaniciAdCek: String, kullaniciUid: String, yemekId: String, yemekAd: String) {
       
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
                if kullaniciAdCek != "" && kullaniciUid != "" && yemekId != "" && yemekAd != "" {
                    // Belge ekleme işlemi
                    var ref: DocumentReference? = nil
                    ref = begenilerRef.addDocument(data: [
                        "begeniId": "",
                        "kullaniciAd": self.kullaniciAdCek,
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
                } else {
                    self.makeAlert(titleInput: "Hata", messageInput: "Bilinmeyen bir hata oluştu", button: "TAMAM")
                }
            }
        }
    }

    
    
    @IBAction func tarifSilButton(_ sender: Any) {
        print("silinecek yemek ıd : \(yemekId)")
        deleteYemekAndBegeniler(yemekId: yemekId)
    }
    
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

