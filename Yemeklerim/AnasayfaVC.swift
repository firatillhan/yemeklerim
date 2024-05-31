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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var yemekListesi = [Yemekler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yemeklerCVTasarim()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        yemekleriCek()
    }
    
    func yemekleriCek(){
        let db = Firestore.firestore()
        db.collection("yemekler").order(by: "yemekTarih", descending: true).addSnapshotListener { (snapshot, error) in
            if let error = error {
                self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription, button: "TAMAM")
                print("Error: \(error)")
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    let group = DispatchGroup()
                    self.yemekListesi.removeAll(keepingCapacity: false)
                    for documentOne in snapshot!.documents {
                        let data = documentOne.data()
                        let yemekId = documentOne.documentID
                        let kullaniciUid = data["kullaniciUid"] as? String ?? "kullanici Uid"
                        let yemekAd = data["yemekAd"] as? String ?? "yemek Ad"
                        let yemekResim = data["yemekResim"] as? String ?? ""
                        let kategori = data["kategori"] as? String ?? ""
                        let yemekAciklama = data["yemekAciklama"] as? String ?? ""
                        let yemekHazirlikSuresi = data["yemekHazirlikSuresi"] as? String ?? ""
                        let yemekKisiSayisi = data["yemekKisiSayisi"] as? String ?? ""
                        let yemekMalzemeler = data["yemekMalzemeler"] as? String ?? ""
                        let yemekPisirmeSuresi = data["yemekPisirmeSuresi"] as? String ?? ""
                        let yemekTarif = data["yemekTarif"] as? String ?? ""
                        group.enter()
                        db.collection("kullanicilar").document(kullaniciUid).getDocument { (document, error) in
                            if let error = error {
                                print("hata \(error)")
                            } else {
                                let kullaniciAd = document?.data()?["kullaniciAd"] as? String ?? "kullaniciAd"
                                let yemek = Yemekler(yemekId: yemekId,kullaniciUid: kullaniciUid,yemekAd: yemekAd,kullaniciAd: kullaniciAd,yemekResim: yemekResim,kategori: kategori,yemekAciklama: yemekAciklama,yemekHazirlikSuresi: yemekHazirlikSuresi,yemekKisiSayisi: yemekKisiSayisi,yemekMalzemeler: yemekMalzemeler,yemekPisirmeSuresi: yemekPisirmeSuresi, yemekTarif: yemekTarif)
                                self.yemekListesi.append(yemek)
                            }
                            group.leave()
                            self.collectionView.reloadData()
                        }
                    }
                    self.collectionView.reloadData()
                }
            }
        }
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
        cell.kullaniciAd.text = yemek.kullaniciAd
        cell.yemekResim.sd_setImage(with: URL(string: yemek.yemekResim))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "homeToDetay", sender: indexPath.row)
    }
    
    
}






extension AnasayfaVC {
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
}


