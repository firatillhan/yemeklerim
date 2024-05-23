//
//  AnasayfaVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import SDWebImage
class AnasayfaVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var yemekListesi = [Yemekler]()
    var kategoriListesi = [Kategoriler]()
    let kullanici = Auth.auth().currentUser!

   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        yemeklerCVTasarim()
        
        // Do any additional setup after loading the view.
        yemekleriGetir()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    
    func yemekleriGetir(){
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("yemekler").addSnapshotListener { (snapshot,error) in
            if error != nil {
                self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata", button: "TAMAM")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.yemekListesi.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID

                        let yemekAd = document.get("yemekAd") as? String
                        let yemekKisiSayisi = document.get("yemekKisiSayisi") as? String
                        let yemekAciklama = document.get("yemekAciklama") as? String
                        let yemekHazirlikSuresi = document.get("yemekHazirlikSuresi") as? String
                        let yemekTarif = document.get("yemekTarif") as? String
                        let yemekResim = document.get("yemekResim") as? String
                        let yemekPisirmeSuresi = document.get("yemekPisirmeSuresi") as? String
                        let yemekMalzemeler = document.get("yemekMalzemeler") as? String
                        let kategori = document.get("kategori") as? String
                        let kullaniciUid = document.get("kullaniciUid") as? String
                        let kullaniciEmail = document.get("kullaniciEmail") as? String
                        
                        let yemek = Yemekler(yemekId: documentID, yemekAd: yemekAd!, yemekKisiSayisi: yemekKisiSayisi!, yemekAciklama: yemekAciklama!, yemekHazirlikSuresi: yemekHazirlikSuresi!, yemekTarif: yemekTarif!, yemekResim: yemekResim!, yemekPisirmeSuresi: yemekPisirmeSuresi!, yemekMalzemeler: yemekMalzemeler!, kategori: kategori!, kullaniciUid: kullaniciUid!, kullaniciEmail: kullaniciEmail!)
                        self.yemekListesi.append(yemek)
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }
   
    
   

    
    
    
    func yemeklerCVTasarim() {
           
        let tasarim :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                
                let genislik = self.collectionView.frame.size.width
                
                tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                
                let hucreGenislik = (genislik-30)/2
                
                tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik*1.7)
                
                tasarim.minimumInteritemSpacing = 10
                tasarim.minimumLineSpacing = 10
                
                collectionView.collectionViewLayout = tasarim
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        let indeks = sender as? Int
            let gidilecekVC = segue.destination as! TarifDetayVC
            gidilecekVC.yemek = yemekListesi[indeks!]
        }
    
    
    
    
   
}
extension AnasayfaVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemekListesi.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let yemek = yemekListesi[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnasayfaCell", for: indexPath) as! AnasayfaCollectionVC
        cell.yemekAd.text = yemek.yemekAd
        cell.kullaniciAd.text = yemek.kullaniciEmail
        cell.yemekResim.sd_setImage(with: URL(string: yemek.yemekResim!))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let yemek = yemekListesi[indexPath.row]
        self.performSegue(withIdentifier: "homeToDetay", sender: indexPath.row)
    }
    
    
}







