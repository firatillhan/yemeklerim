//
//  AnasayfaVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AnasayfaVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var yemekListesi = [Yemekler]()
    let kullanici = Auth.auth().currentUser!

  //  var ref:DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        yemeklerCVTasarim()
        
        // Do any additional setup after loading the view.
       //yemekleriGetir()
        tumYemekleriGetir()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func yemekleriGetir(){
//        let fireStoreDatabase = Firestore.firestore()
//        fireStoreDatabase.collection("yemekler").addSnapshotListener { (snapshot,error) in
//            if error != nil {
//                self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata", button: "TAMAM")
//            } else {
//                if snapshot?.isEmpty != true && snapshot != nil {
//                    self.yemekListesi.removeAll(keepingCapacity: false)
//                    
//                    for document in snapshot!.documents {
//                        let documentID = document.documentID
//                        
//                       
//                        
//                        
//                    }
//                    self.collectionView.reloadData()
//                }
//            }
//        }
    }
    
    
    func tumYemekleriGetir(){
 
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
        cell.yemekResim.image = UIImage(named: "select")
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "homeToDetay", sender: indexPath.row)
        print("Tıklandı")
    }
    
    
}







