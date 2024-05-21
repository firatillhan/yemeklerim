//  ProfilVC.swift
//  Yemeklerim
//  Created by Fırat İlhan on 24.04.2024.

import UIKit
import FirebaseFirestore
import FirebaseAuth
import SDWebImage

class ProfilVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var emptyMessageLabel: UILabel!
    var yemekListesi = [Yemekler]()
    
    @IBOutlet weak var userProfilPhoto: UIImageView!
    @IBOutlet weak var tarifSayisiLabel: UILabel!
    
    @IBOutlet weak var kullaniciAd: UILabel!
    @IBOutlet weak var kullaniciAdSoyad: UILabel!
    @IBOutlet weak var kullaniciEmail: UILabel!
    @IBOutlet weak var kullaniciAciklama: UILabel!
    
    let kullanici = Auth.auth().currentUser!
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        yemeklerCVTasarim()
        userProfilPhoto.layer.cornerRadius = CGRectGetWidth(self.userProfilPhoto.frame) / 2
        userProfilPhoto.layer.borderWidth = 2
        userData()
        
        navigationController?.navigationBar.topItem?.title = kullanici.email!

        // UILabel oluşturma
        emptyMessageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        emptyMessageLabel.text = "Henüz tarif yüklemediniz"
        self.tarifSayisiLabel.text = "0"
        emptyMessageLabel.textColor = .gray
        emptyMessageLabel.textAlignment = .center
        emptyMessageLabel.font = UIFont.systemFont(ofSize: 20)
        
        collectionView.backgroundView = emptyMessageLabel
        yemekleriGetir()
        yemekSayisiCek()
       

        
    }


    override func viewWillAppear(_ animated: Bool) {
        userData()
        yemekleriGetir()
        yemekSayisiCek()
    }
    
    func yemekSayisiCek() {
        let db = Firestore.firestore()
        let sorgu = db.collection("yemekler").whereField("kullaniciEmail", isEqualTo: kullanici.email!)
        sorgu.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let querySnapshot = querySnapshot {
                    if querySnapshot.documents.count == 0 {
                        self.emptyMessageLabel.isHidden = false
                        print("liste boş: \(querySnapshot.documents.count)")
                        let sayi = querySnapshot.documents.count
                        self.tarifSayisiLabel.text = "\(sayi)"
                    } else {
                        self.emptyMessageLabel.isHidden = true
                        let sayi = querySnapshot.documents.count
                        print("liste boş değil: \(sayi)")
                        self.tarifSayisiLabel.text = "\(sayi)"
                    }
                }
            }
        }
    }
    
    
    
    func userData(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("kullanicilar").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                self.navigationController?.navigationBar.topItem?.title = data?["kullaniciAd"] as? String ?? ""
                self.kullaniciAdSoyad.text = data?["kullaniciAdSoyad"] as? String ?? ""
                self.kullaniciEmail.text = data?["kullaniciEmail"] as? String ?? ""
                self.kullaniciAciklama.text = data?["kullaniciAciklama"] as? String ?? ""
                if let imageURL = data?["kullaniciResim"] as? String, let url = URL(string: imageURL) {
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        if let data = data, error == nil {
                            DispatchQueue.main.async {
                                self.userProfilPhoto.image = UIImage(data: data)
                            }
                        }
                    }.resume()
                }
                
            } else {
                print("Document does not exist")
            }
        }
        
        
    }
    
    func yemekleriGetir(){
        let fireStoreDatabase = Firestore.firestore()
        let sorgu = fireStoreDatabase.collection("yemekler").whereField("kullaniciEmail", isEqualTo: kullanici.email!)
        sorgu.addSnapshotListener { (snapshot,error) in
            if error != nil {
                self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata", button: "TAMAM")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.yemekListesi.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID

                        let yemekAd = document.get("yemekAd") as? String
                        let yemekKisiSayisi = document.get("yemekKisiSayisi") as? String
                        let yemekAciklama = document.get("yemekAciklama") as? String
                        let yemekHazirlikSuresi = document.get("yemekHazirlikSuresi") as? String
                        let yemekTarif = document.get("yemekTarif") as? String
                        let yemekResim = document.get("yemekResim") as? String
                        let yemekPisirmeSuresi = document.get("yemekPisirmeSuresi") as? String
                        let yemekMalzemeler = document.get("yemekMalzemeler") as? String
                        let kategori = document.get("kategori") as? String
                        let kullaniciUid = document.get("kullaniciUid") as? String
                        let kullaniciEmail = document.get("kullaniciEmail") as? String
                        
                        let yemek = Yemekler(yemekId: documentID, yemekAd: yemekAd!, yemekKisiSayisi: yemekKisiSayisi!, yemekAciklama: yemekAciklama!, yemekHazirlikSuresi: yemekHazirlikSuresi!, yemekTarif: yemekTarif!, yemekResim: yemekResim!, yemekPisirmeSuresi: yemekPisirmeSuresi!, yemekMalzemeler: yemekMalzemeler!, kategori: kategori!, kullaniciUid: kullaniciUid!, kullaniciEmail: kullaniciEmail!)
                        self.yemekListesi.append(yemek)
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        if segue.identifier == "profilToDetay" {
            
            if let destinationVC = segue.destination as? TarifDetayVC {
                let indeks = sender as? Int
                destinationVC.yemek = yemekListesi[indeks!]
                
            }
        } else if segue.identifier == "profilDuzenle" {
            if let destinationVC = segue.destination as? ProfilDuzenleVC {

            }
        }
        
        
        
        
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
        performSegue(withIdentifier: "profilDuzenle", sender: nil)
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "logOut", sender: nil)
        } catch {
            
        }
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
        cell.yemekResim.sd_setImage(with: URL(string: yemek.yemekResim!))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yemek = yemekListesi[indexPath.row]
        self.performSegue(withIdentifier: "profilToDetay", sender: indexPath.row)
        print("seçilen hucre: \(yemek.yemekAd!)")

    }
    
    
    
    
}
