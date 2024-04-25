//
//  TarifYukleVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit

class TarifYukleVC: UIViewController {
    
    @IBOutlet weak var yemekAd: UITextField!
    @IBOutlet weak var yemekAciklama: UITextField!
    @IBOutlet weak var yemekKisiSayisi: UIPickerView!    //picker!
    @IBOutlet weak var yemekResim: UIImageView!
    @IBOutlet weak var yemekHazirlikSuresi: UITextField!
    @IBOutlet weak var yemekPisirmeSuresi: UITextField!
    @IBOutlet weak var yemekMalzemeler: UITextField!
    @IBOutlet weak var KategoriId: UIPickerView!   //picker!
    @IBOutlet weak var yemekTarif: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



    @IBAction func tarifYukleButton(_ sender: Any) {
        
    }
}
