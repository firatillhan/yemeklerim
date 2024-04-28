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
        
       
        let favori1 = FavoriYemekler(favoriYemekId: "1", yemek: Yemekler(yemekId: "1", yemekAd: "Mercimek Çorbası", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Nefis mercimek çorbası", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "çorba", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
        
        let favori2 = FavoriYemekler(favoriYemekId: "2", yemek: Yemekler(yemekId: "2", yemekAd: "Bulgur Pilavı", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "bulgurPilavı", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
        
        let favori3 = FavoriYemekler(favoriYemekId: "3", yemek: Yemekler(yemekId: "3", yemekAd: "tavuk sote", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Nefis mercimek çorbası", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "tavukSote", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
        
        let favori4 = FavoriYemekler(favoriYemekId: "4", yemek: Yemekler(yemekId: "4", yemekAd: "peynir eritmesi", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Nefis mercimek çorbası", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "peynirEritmesi", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
        let favori5 = FavoriYemekler(favoriYemekId: "5", yemek: Yemekler(yemekId: "5", yemekAd: "ezogelin çorbası", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Nefis mercimek çorbası", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "ezogelinCorbasi", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
        
        let favori6 = FavoriYemekler(favoriYemekId: "6", yemek: Yemekler(yemekId: "6", yemekAd: "magnolia", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Nefis mercimek çorbası", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "magnolia", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
       
        let favori7 = FavoriYemekler(favoriYemekId: "1", yemek: Yemekler(yemekId: "1", yemekAd: "Mercimek Çorbası", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Nefis mercimek çorbası", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "çorba", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
        
        let favori8 = FavoriYemekler(favoriYemekId: "2", yemek: Yemekler(yemekId: "2", yemekAd: "Bulgur Pilavı", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "bulgurPilavı", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
        
        let favori9 = FavoriYemekler(favoriYemekId: "3", yemek: Yemekler(yemekId: "3", yemekAd: "tavuk sote", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Nefis mercimek çorbası", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "tavukSote", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
        
        let favori10 = FavoriYemekler(favoriYemekId: "4", yemek: Yemekler(yemekId: "4", yemekAd: "peynir eritmesi", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Nefis mercimek çorbası", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "peynirEritmesi", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
        let favori11 = FavoriYemekler(favoriYemekId: "5", yemek: Yemekler(yemekId: "5", yemekAd: "ezogelin çorbası", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Nefis mercimek çorbası", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "ezogelinCorbasi", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
        
        let favori12 = FavoriYemekler(favoriYemekId: "6", yemek: Yemekler(yemekId: "6", yemekAd: "magnolia", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Nefis mercimek çorbası", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "magnolia", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
        
        favoriTarifListesi.append(favori1)
        favoriTarifListesi.append(favori2)
        favoriTarifListesi.append(favori3)
        favoriTarifListesi.append(favori4)
        favoriTarifListesi.append(favori5)
        favoriTarifListesi.append(favori6)
        favoriTarifListesi.append(favori7)
        favoriTarifListesi.append(favori8)
        favoriTarifListesi.append(favori9)
        favoriTarifListesi.append(favori10)
        favoriTarifListesi.append(favori11)
        favoriTarifListesi.append(favori12)
        
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
        print("Favori detay tıklandı")


    }
    
    
}
