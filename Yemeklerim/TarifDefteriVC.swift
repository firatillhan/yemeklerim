//
//  TarifDefteriVC.swift
//  Yemeklerim
//
//  Created by Fırat İlhan on 24.04.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class TarifDefteriVC: UIViewController {

    var begeniIdArray = [String]()
    var kullaniciEmailArray = [String]()
    var kullaniciUidArray = [String]()
    var yemekIdArray = [String]()
    var yemekAdArray = [String]()
    
   var favori = String()
    
    let db = Firestore.firestore()
    let kullanici = Auth.auth().currentUser!
 
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        favoriyemekleriGetir(kullaniciEmail: kullanici.email!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "favoriToDetay" {
            let destinationVC = segue.destination as! TarifDetayVC
            destinationVC.gelenYemekId = favori
            }
        }
    
    


    func favoriyemekleriGetir(kullaniciEmail:String){
        let fireStoreDatabase = Firestore.firestore()
        

        fireStoreDatabase.collection("begeniler").whereField("kullaniciEmail", isEqualTo: kullaniciEmail).addSnapshotListener { [self] (snapshot,error) in
            if error != nil {
                self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata", button: "TAMAM")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.begeniIdArray.removeAll(keepingCapacity: false)
                    self.yemekIdArray.removeAll(keepingCapacity: false)
                    self.yemekAdArray.removeAll(keepingCapacity: false)

                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.begeniIdArray.append(documentID)
                        
                        if let yemekAd = document.get("yemekAd") as? String {
                            self.yemekAdArray.append(yemekAd)
                        }
                        if let yemekId = document.get("yemekId") as? String {
                            self.yemekIdArray.append(yemekId)
                            
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    

    
    
    
    

  
}
extension TarifDefteriVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemekAdArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriCell", for: indexPath) as! TarifDefteriTableVC
        cell.favoriTarifAdLabel.text = yemekAdArray[indexPath.row]
        cell.favoriTarifYemekIdLabel.text = yemekIdArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        favori = yemekIdArray[indexPath.row]
        self.performSegue(withIdentifier: "favoriToDetay", sender: indexPath.row)
       
       


    }
    
    
}
