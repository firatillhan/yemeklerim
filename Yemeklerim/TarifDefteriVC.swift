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
    
    var begeniListesi = [Favoriler]()
    let kullanici = Auth.auth().currentUser!
    
    
    var gonderilenYemekId = String()
    var emptyMessageLabel: UILabel!
    let db = Firestore.firestore()
    
    var begeniId = String()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("tarifDefteri vc view will appear çalıştı")
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
        
        let indeks = sender as? Int
        let gidilecekVC = segue.destination as! TarifDetayVC
        gidilecekVC.favori = begeniListesi[indeks!]
    
}
    
    


    func favoriyemekleriGetir(){
    
        db.collection("begeniler").whereField("kullaniciUid", isEqualTo: kullanici.uid).addSnapshotListener { (snapshot,error) in
            if error != nil {
                self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata", button: "TAMAM")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    let group = DispatchGroup()
                    self.begeniListesi.removeAll(keepingCapacity: false)

                    for document in snapshot!.documents {
                        let data = document.data()
                        
                        let begeniId = document.documentID
                        let yemekId = data["yemekId"] as? String ?? ""
                        let kullaniciUid = data["kullaniciUid"] as? String ?? ""
                        
                        group.enter()
                        self.db.collection("yemekler").document(yemekId).getDocument { document, error in
                            if let error = error {
                                print("Error \(error)")
                            } else {
                                let yemekAd = document?.data()?["yemekAd"] as? String ?? "yemekAd"
                                 let begeni = Favoriler(begeniId: begeniId, kullaniciUid: kullaniciUid, yemekId: yemekId, yemekAd: yemekAd)

                                 self.begeniListesi.append(begeni)
                            }
                            group.leave()
                            self.tableView.reloadData()
                        }

                            
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    func begeniSil(begeniId:String){
        print("silinecek beğeni id: \(self.begeniId)")
        
        db.collection("begeniler").document(begeniId).delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                //self.Alert(titleInput: "Tebrikler", messageInput: "Başarılı bir şekilde begenilerden çıkarıldı!", button: "TAMAM")
                self.Alert(titleInput: "UYARI", messageInput: "Beğendiğiniz tarif listenizden çıkarıldı", button: "Tamam")
                self.begeniListesi.removeAll(keepingCapacity: false)
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
        return begeniListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let begeni = begeniListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriCell", for: indexPath) as! TarifDefteriTableVC
        cell.favoriTarifAdLabel.text = begeni.yemekAd
        cell.favoriTarifYemekIdLabel.text = begeni.yemekId
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "favoriToDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil") {
            (contextualAction, view, boolValue) in
   
            let begeni = self.begeniListesi[indexPath.row]
            self.begeniSil(begeniId: begeni.begeniId)
            self.makeAlert(titleInput: "Tebrikler", messageInput: "Tarif Listenizden Çıkarıldı", button: "TAMAM")
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])

    }
    
    
    

  

    

    
   
}
