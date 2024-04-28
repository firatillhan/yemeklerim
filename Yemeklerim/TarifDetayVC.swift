//
//  TarifDetayVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    

    @IBAction func deftereEkleButton(_ sender: Any) {
        self.makeAlert(titleInput: "Tebrikler", messageInput: "Tarif deftere eklendi", button: "Tamam")
    }
    



}
