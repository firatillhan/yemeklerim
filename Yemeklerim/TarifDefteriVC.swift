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
