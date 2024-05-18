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
        
       
//        let favori1 = FavoriYemekler(favoriYemekId: "1", yemek: Yemekler(yemekId: "1", yemekAd: "Mercimek Çorbası", yemekKisiSayisi: "4 kişilik", yemekAciklama: "Nefis mercimek çorbası", yemekHazirlikSuresi: "20 dakika", yemekTarif: "mercimek çorbası tarifi", yemekResim: "çorba", yemekPisirmeSuresi: "30 dakika", yemekMalzemeler: "mercimek çorbası için gerekli tarifler", kategori: Kategoriler(kategoriId: "", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "firatilhan08", kullaniciAdSoyad: "Fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "Bilgisayar mühendisliği öğrencisi", kullaniciSifre: "111222333", kullaniciEmail: "firatilhan008@gmail.com")))
//        
//      
//        
//        favoriTarifListesi.append(favori1)
       
        
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
