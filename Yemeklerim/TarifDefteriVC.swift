//
//  TarifDefteriVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit

class TarifDefteriVC: UIViewController {

    var favoriTarifListesi = [FavoriYemekler]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        let favori1 = FavoriYemekler(favoriYemekId: "1", yemek: Yemekler(yemekId: "1", yemekAd: "Mercimek Çorbası", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "Nefis mercimek Çorbası", yemekHazirlikSuresi: "10 dakika", yemekTarif: "mercimek çorbası tarifu", yemekResim: "çorba", yemekPisirmeSuresi: "30 dk", yemekMalzemeler: "mercimek çorbası malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com")))
        let favori2 = FavoriYemekler(favoriYemekId: "2", yemek: Yemekler(yemekId: "", yemekAd: "Bulgur Pilavı", yemekKisiSayisi: "", yemekAciklama: "", yemekHazirlikSuresi: "", yemekTarif: "", yemekResim: "", yemekPisirmeSuresi: "", yemekMalzemeler: "", kategori: Kategoriler(kategoriId: "", kategoriAd: ""), kullanici: Kullanicilar(kullaniciAd: "", sifre: "", email: "")))
        let favori3 = FavoriYemekler(favoriYemekId: "3", yemek: Yemekler(yemekId: "", yemekAd: "Peynir Eritmesi", yemekKisiSayisi: "", yemekAciklama: "", yemekHazirlikSuresi: "", yemekTarif: "", yemekResim: "", yemekPisirmeSuresi: "", yemekMalzemeler: "", kategori: Kategoriler(kategoriId: "", kategoriAd: ""), kullanici: Kullanicilar(kullaniciAd: "", sifre: "", email: "")))
        let favori4 = FavoriYemekler(favoriYemekId: "4", yemek: Yemekler(yemekId: "", yemekAd: "Pirinç Pilavı", yemekKisiSayisi: "", yemekAciklama: "", yemekHazirlikSuresi: "", yemekTarif: "", yemekResim: "", yemekPisirmeSuresi: "", yemekMalzemeler: "", kategori: Kategoriler(kategoriId: "", kategoriAd: ""), kullanici: Kullanicilar(kullaniciAd: "", sifre: "", email: "")))
        let favori5 = FavoriYemekler(favoriYemekId: "5", yemek: Yemekler(yemekId: "", yemekAd: "Tavuk Sote", yemekKisiSayisi: "", yemekAciklama: "", yemekHazirlikSuresi: "", yemekTarif: "", yemekResim: "", yemekPisirmeSuresi: "", yemekMalzemeler: "", kategori: Kategoriler(kategoriId: "", kategoriAd: ""), kullanici: Kullanicilar(kullaniciAd: "", sifre: "", email: "")))
        let favori6 = FavoriYemekler(favoriYemekId: "6", yemek: Yemekler(yemekId: "", yemekAd: "Kuru Fasülye", yemekKisiSayisi: "", yemekAciklama: "", yemekHazirlikSuresi: "", yemekTarif: "", yemekResim: "", yemekPisirmeSuresi: "", yemekMalzemeler: "", kategori: Kategoriler(kategoriId: "", kategoriAd: ""), kullanici: Kullanicilar(kullaniciAd: "", sifre: "", email: "")))
        favoriTarifListesi.append(favori1)
        favoriTarifListesi.append(favori2)
        favoriTarifListesi.append(favori3)
        favoriTarifListesi.append(favori4)
        favoriTarifListesi.append(favori5)
        favoriTarifListesi.append(favori6)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let indeks = sender as? Int
            let gidilecekVC = segue.destination as! TarifDetayVC
            gidilecekVC.favori = favoriTarifListesi[indeks!]
        }
    

  
}
extension TarifDefteriVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriTarifListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favori = favoriTarifListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriCell", for: indexPath) as! TarifDefteriTableVC
        cell.favoriTarifAdLabel.text = favori.yemek?.yemekAd
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "favoriToDetay", sender: indexPath.row)

    }
    
    
}
