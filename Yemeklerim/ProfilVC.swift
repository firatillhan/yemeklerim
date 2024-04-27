//
//  ProfilVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit

class ProfilVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var yemekListesi = [Yemekler]()
    
    @IBOutlet weak var kullaniciLabel: UILabel!
    @IBOutlet weak var userProfilPhoto: UIImageView!
    
    @IBOutlet weak var kullaniciAdiLabel: UIBarButtonItem!
    
    @IBOutlet weak var kullaniciAciklama: UILabel!
    
    
    
    @IBOutlet weak var tarifSayisiLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        yemeklerCVTasarim()
        userProfilPhoto.layer.cornerRadius = CGRectGetWidth(self.userProfilPhoto.frame) / 2
        userProfilPhoto.layer.borderWidth = 2
        
        
        
        
        let yemek1 = Yemekler(yemekId: "1", yemekAd: "Mercimek Çorbası", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "mercimek çorbası açıklaması", yemekHazirlikSuresi: "10 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "çorba", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com"))
        let yemek2 = Yemekler(yemekId: "2", yemekAd: "Tavuk Sote", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "Tavuk sote açıklaması", yemekHazirlikSuresi: "20 dakika", yemekTarif: "tavuk sote tarifi", yemekResim: "tavukSote", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "tavuk sote malzemeler", kategori: Kategoriler(kategoriId: "2", kategoriAd: "Ana Yemekler"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com"))
        
        let yemek3 = Yemekler(yemekId: "3", yemekAd: "Bulgur Pilavı", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "bulgur pilavı açıklaması", yemekHazirlikSuresi: "10 dakika", yemekTarif: "bulgur pilavı tarifi", yemekResim: "bulgurPilavi", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "bulgur pilavı malzemeler", kategori: Kategoriler(kategoriId: "3", kategoriAd: "Pilav ve Makarnalar"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com"))
        let yemek4 = Yemekler(yemekId: "4", yemekAd: "Peynir eritmesi", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "Artvin usulü peynir eritmesi açıklaması", yemekHazirlikSuresi: "5 dakika", yemekTarif: "peynir eritmesi tarifi", yemekResim: "peynirEritmesi", yemekPisirmeSuresi: "5 dakika", yemekMalzemeler: "peynir eritmesi malzemeler", kategori: Kategoriler(kategoriId: "3", kategoriAd: "Kahvaltılıklar"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com"))
        let yemek5 = Yemekler(yemekId: "5", yemekAd: "Mercimek Çorbası", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "mercimek çorbası açıklaması", yemekHazirlikSuresi: "10 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "çorba", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com"))
        let yemek6 = Yemekler(yemekId: "6", yemekAd: "Tavuk Sote", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "Tavuk sote açıklaması", yemekHazirlikSuresi: "20 dakika", yemekTarif: "tavuk sote tarifi", yemekResim: "tavukSote", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "tavuk sote malzemeler", kategori: Kategoriler(kategoriId: "2", kategoriAd: "Ana Yemekler"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com"))
        
        let yemek7 = Yemekler(yemekId: "7", yemekAd: "Bulgur Pilavı", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "bulgur pilavı açıklaması", yemekHazirlikSuresi: "10 dakika", yemekTarif: "bulgur pilavı tarifi", yemekResim: "bulgurPilavi", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "bulgur pilavı malzemeler", kategori: Kategoriler(kategoriId: "3", kategoriAd: "Pilav ve Makarnalar"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com"))
        let yemek8 = Yemekler(yemekId: "8", yemekAd: "Peynir eritmesi", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "Artvin usulü peynir eritmesi açıklaması", yemekHazirlikSuresi: "5 dakika", yemekTarif: "peynir eritmesi tarifi", yemekResim: "peynirEritmesi", yemekPisirmeSuresi: "5 dakika", yemekMalzemeler: "peynir eritmesi malzemeler", kategori: Kategoriler(kategoriId: "3", kategoriAd: "Kahvaltılıklar"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com"))
        let yemek9 = Yemekler(yemekId: "9", yemekAd: "Mercimek Çorbası", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "mercimek çorbası açıklaması", yemekHazirlikSuresi: "10 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "çorba", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com"))
        let yemek10 = Yemekler(yemekId: "2", yemekAd: "Tavuk Sote", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "Tavuk sote açıklaması", yemekHazirlikSuresi: "20 dakika", yemekTarif: "tavuk sote tarifi", yemekResim: "tavukSote", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "tavuk sote malzemeler", kategori: Kategoriler(kategoriId: "2", kategoriAd: "Ana Yemekler"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com"))
        
        let yemek11 = Yemekler(yemekId: "3", yemekAd: "Bulgur Pilavı", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "bulgur pilavı açıklaması", yemekHazirlikSuresi: "10 dakika", yemekTarif: "bulgur pilavı tarifi", yemekResim: "bulgurPilavi", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "bulgur pilavı malzemeler", kategori: Kategoriler(kategoriId: "3", kategoriAd: "Pilav ve Makarnalar"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com"))
        let yemek12 = Yemekler(yemekId: "4", yemekAd: "Peynir eritmesi", yemekKisiSayisi: "2-4 kişilik", yemekAciklama: "Artvin usulü peynir eritmesi açıklaması", yemekHazirlikSuresi: "5 dakika", yemekTarif: "peynir eritmesi tarifi", yemekResim: "peynirEritmesi", yemekPisirmeSuresi: "5 dakika", yemekMalzemeler: "peynir eritmesi malzemeler", kategori: Kategoriler(kategoriId: "3", kategoriAd: "Kahvaltılıklar"), kullanici: Kullanicilar(kullaniciAd: "firat", sifre: "123456", email: "firatilhan008@gmail.com"))
        
        
        
        
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
    }
    
    func yemeklerCVTasarim() {
           
        let tasarim :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                
                let genislik = self.collectionView.frame.size.width
                
                tasarim.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
                let hucreGenislik = (genislik)/3
                
                tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik)
                
                tasarim.minimumInteritemSpacing = 0
                tasarim.minimumLineSpacing = 0
                
                collectionView.collectionViewLayout = tasarim
        }

    @IBAction func profilDuzenleButton(_ sender: Any) {
        self.makeAlert(titleInput: "Hata!", messageInput: "Düzenle Sayfasına Ulaşılamadı", button: "Tamam")
    }
    
}

extension ProfilVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemekListesi.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let yemek = yemekListesi[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profilCollectionView", for: indexPath) as! ProfilCollectionVC
        cell.yemekResim.image = UIImage(named: yemek.yemekResim!)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "profilToDetay", sender: indexPath.row)
        print("profil yemek detay tıklandı")

    }
    
    
}
