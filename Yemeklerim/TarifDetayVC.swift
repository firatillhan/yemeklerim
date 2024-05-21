//
//  TarifDetayVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit
import FirebaseFirestore

class TarifDetayVC: UIViewController {
    
    var yemek:Yemekler?
    var favori:FavoriYemekler?
    
    @IBOutlet weak var yemekResim: UIImageView!
    @IBOutlet weak var kullaniciFoto: UIImageView!
    @IBOutlet weak var kullaniciAd: UILabel!
    @IBOutlet weak var yemekKisiSayisi: UILabel!
    @IBOutlet weak var yemekHazirlikSayisi: UILabel!
    @IBOutlet weak var yemekPisirmeSuresi: UILabel!
    @IBOutlet weak var yemekAciklama: UILabel!
    @IBOutlet weak var yemekMalzemeler: UILabel!
    @IBOutlet weak var yemekTarif: UILabel!
    
    @IBOutlet weak var kategoriLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if let y = yemek{
            navigationItem.title = "Kategori: \(y.kategori!)"
            kategoriLabel.text = y.yemekAd
            yemekKisiSayisi.text = "\(y.yemekKisiSayisi!) Kişilik"
            yemekHazirlikSayisi.text = "Hazırlık: \(y.yemekHazirlikSuresi!)"
            yemekPisirmeSuresi.text = "Pişirme: \(y.yemekPisirmeSuresi!)"
            yemekAciklama.text = y.yemekAciklama
            yemekMalzemeler.text = y.yemekMalzemeler
            yemekTarif.text = y.yemekTarif
            kullaniciAd.text = y.kullaniciEmail
            if let resimUrl = y.yemekResim {
                yemekResim.sd_setImage(with: URL(string: resimUrl))
            }
        }
    }
    @IBAction func deftereEkleButton(_ sender: Any) {
        self.makeAlert(titleInput: "Tebrikler", messageInput: "Tarif deftere eklendi", button: "Tamam")
    }
}
