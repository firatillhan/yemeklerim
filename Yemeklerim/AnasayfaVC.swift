//
//  AnasayfaVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit

class AnasayfaVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var yemekListesi = [Yemekler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yemeklerCVTasarim()
        
        // Do any additional setup after loading the view.
        
        let yemek1 = Yemekler(yemekId: "1", yemekAd: "Mercimek Çorbası", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "çorba", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
        
        let yemek2 = Yemekler(yemekId: "1", yemekAd: "Bulgur Pilavı", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "bulgurPilavi", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Pilavlar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
        
        let yemek3 = Yemekler(yemekId: "1", yemekAd: "Tavuk sote", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "tavukSote", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Tavuk Yemekleri"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
        
        let yemek4 = Yemekler(yemekId: "1", yemekAd: "Ezogelin Çorbası", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "ezogelinCorbasi", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
        
        let yemek5 = Yemekler(yemekId: "1", yemekAd: "magnolia", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "magnolia", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Tatlılar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
        
        let yemek6 = Yemekler(yemekId: "1", yemekAd: "Peynir Eritmesi", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "peynirEritmesi", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Kahvaltılıklar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
        
        let yemek7 = Yemekler(yemekId: "1", yemekAd: "Mercimek Çorbası", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "çorba", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
        
        let yemek8 = Yemekler(yemekId: "1", yemekAd: "Bulgur Pilavı", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "bulgurPilavi", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Pilavlar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
        
        let yemek9 = Yemekler(yemekId: "1", yemekAd: "Tavuk sote", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "tavukSote", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Tavuk Yemekleri"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
        
        let yemek10 = Yemekler(yemekId: "1", yemekAd: "Ezogelin Çorbası", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "ezogelinCorbasi", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
        
        let yemek11 = Yemekler(yemekId: "1", yemekAd: "magnolia", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "magnolia", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Tatlılar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
        
        let yemek12 = Yemekler(yemekId: "1", yemekAd: "Peynir Eritmesi", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "peynirEritmesi", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Kahvaltılıklar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
        
      
      
        
        yemekListesi.append(yemek1)
        yemekListesi.append(yemek2)
        yemekListesi.append(yemek3)
        yemekListesi.append(yemek4)
        yemekListesi.append(yemek5)
        yemekListesi.append(yemek6)
        yemekListesi.append(yemek7)
        yemekListesi.append(yemek8)
        yemekListesi.append(yemek9)
        yemekListesi.append(yemek10)
        yemekListesi.append(yemek11)
        yemekListesi.append(yemek12)

        
        collectionView.delegate = self
        collectionView.dataSource = self

        
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
        cell.kullaniciAd.text = yemek.kullanici?.kullaniciAd
        cell.yemekResim.image = UIImage(named: yemek.yemekResim!)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "homeToDetay", sender: indexPath.row)
        print("Tıklandı")
    }
    
    
}


