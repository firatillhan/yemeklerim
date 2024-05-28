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
    var kullaniciAdArray = [String]()
    var kullaniciUidArray = [String]()
    var yemekIdArray = [String]()
    var yemekAdArray = [String]()
    
    var gonderilenYemeId = String()

    var emptyMessageLabel: UILabel!

    
    let db = Firestore.firestore()
    let kullanici = Auth.auth().currentUser!
    var silinecekBegeniId = String()
    
 
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        favoriyemekleriGetir()
        favoriSayisiCek()
        bosLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
       print("view will appear çalıştı")
        favoriyemekleriGetir()
        favoriSayisiCek()
        bosLabel()
    }
    func bosLabel(){
        emptyMessageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        emptyMessageLabel.text = "Henüz yemek tarifi beğenmediniz..."
        emptyMessageLabel.textColor = .gray
        emptyMessageLabel.textAlignment = .center
        emptyMessageLabel.font = UIFont.systemFont(ofSize: 20)
        
        tableView.backgroundView = emptyMessageLabel
    }
    func favoriSayisiCek() {
        //favori sayısı 0 ise ekrana henüz yemek tarifi beğenmediniz yazısı gelecek.
       
        let sorgu = db.collection("begeniler").whereField("kullaniciUid", isEqualTo: kullanici.uid)
        sorgu.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let querySnapshot = querySnapshot {
                    let sayi = querySnapshot.documents.count
                    if  sayi == 0 {
                        self.emptyMessageLabel.isHidden = false
                        print("liste boş: \(sayi)")
                        
                    } else {
                        self.emptyMessageLabel.isHidden = true
                        print("liste boş değil")
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "favoriToDetay" {
            let destinationVC = segue.destination as! TarifDetayVC
            destinationVC.gelenYemekId = gonderilenYemeId
            }
        }
    
    


    func favoriyemekleriGetir(){
    
        db.collection("begeniler").whereField("kullaniciUid", isEqualTo: kullanici.uid).addSnapshotListener { (snapshot,error) in
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

    func begeniSil(begeniId:String){
        print("silinecek beğeni id: \(self.silinecekBegeniId)")
        
        db.collection("begeniler").document(silinecekBegeniId).delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                //self.Alert(titleInput: "Tebrikler", messageInput: "Başarılı bir şekilde begenilerden çıkarıldı!", button: "TAMAM")
                self.Alert(titleInput: "UYARI", messageInput: "Beğendiğiniz tarif listenizden çıkarıldı", button: "Tamam")
                self.begeniIdArray.removeAll(keepingCapacity: false)
                self.yemekIdArray.removeAll(keepingCapacity: false)
                self.yemekAdArray.removeAll(keepingCapacity: false)
                self.tableView.reloadData()
                self.viewWillAppear(true)
            }
        }
    }

    
    func Alert(titleInput:String,messageInput:String,button:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: button, style: .default) { UIAlertAction in
            self.alertTamam()
        }
        alert.addAction(button)
        self.present(alert, animated: true, completion: nil)
    }
    @objc func alertTamam(){
        self.favoriyemekleriGetir()
    }
    
    
    

  
}
extension TarifDefteriVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemekIdArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriCell", for: indexPath) as! TarifDefteriTableVC
        cell.favoriTarifAdLabel.text = yemekAdArray[indexPath.row]
        cell.favoriTarifYemekIdLabel.text = yemekIdArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        gonderilenYemeId = yemekIdArray[indexPath.row]
        self.performSegue(withIdentifier: "favoriToDetay", sender: indexPath.row)
       
       


    }
  
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil") {
                 (contextualAction, view, boolValue) in
            self.silinecekBegeniId = self.begeniIdArray[indexPath.row]
            self.begeniSil(begeniId:self.silinecekBegeniId)
             }
             return UISwipeActionsConfiguration(actions: [silAction])
         }
   
}
