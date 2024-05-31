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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        yemeklerCVTasarim()
        userProfilPhoto.layer.cornerRadius = CGRectGetWidth(self.userProfilPhoto.frame) / 2
        userProfilPhoto.layer.borderWidth = 2
        
        navigationController?.navigationBar.topItem?.title = kullanici.email!
        self.tarifSayisiLabel.text = "0"
        emptyMessageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        emptyMessageLabel.text = "Henüz tarif yüklemediniz"
        emptyMessageLabel.textColor = .gray
        emptyMessageLabel.textAlignment = .center
        emptyMessageLabel.font = UIFont.systemFont(ofSize: 20)
        collectionView.backgroundView = emptyMessageLabel
    }


    override func viewWillAppear(_ animated: Bool) {
        yemekleriCek()
        yemekSayisiCek()
        userData()
    }
    
    func yemekSayisiCek() {
        let db = Firestore.firestore()
        let sorgu = db.collection("yemekler").whereField("kullaniciUid", isEqualTo: kullanici.uid)
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
    
    func yemekleriCek(){
        let db = Firestore.firestore()
        db.collection("yemekler").whereField("kullaniciUid", isEqualTo: kullanici.uid).addSnapshotListener { (snapshot, error) in
            if let error = error {
                self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription, button: "TAMAM")
                print("Error: \(error)")
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    let group = DispatchGroup()
                    self.yemekListesi.removeAll(keepingCapacity: false)
                    for documentOne in snapshot!.documents {
                        let data = documentOne.data()
                        let yemekId = documentOne.documentID
                        let kullaniciUid = data["kullaniciUid"] as? String ?? "kullanici Uid"
                        let yemekAd = data["yemekAd"] as? String ?? "yemek Ad"
                        let yemekResim = data["yemekResim"] as? String ?? ""
                        let kategori = data["kategori"] as? String ?? ""
                        let yemekAciklama = data["yemekAciklama"] as? String ?? ""
                        let yemekHazirlikSuresi = data["yemekHazirlikSuresi"] as? String ?? ""
                        let yemekKisiSayisi = data["yemekKisiSayisi"] as? String ?? ""
                        let yemekMalzemeler = data["yemekMalzemeler"] as? String ?? ""
                        let yemekPisirmeSuresi = data["yemekPisirmeSuresi"] as? String ?? ""
                        let yemekTarif = data["yemekTarif"] as? String ?? ""
                        group.enter()
                        db.collection("kullanicilar").document(kullaniciUid).getDocument { (document, error) in
                            if let error = error {
                                print("hata \(error)")
                            } else {
                                let kullaniciAd = document?.data()?["kullaniciAd"] as? String ?? "kullaniciAd"
                                let yemek = Yemekler(yemekId: yemekId,kullaniciUid: kullaniciUid,yemekAd: yemekAd,kullaniciAd: kullaniciAd,yemekResim: yemekResim,kategori: kategori,yemekAciklama: yemekAciklama,yemekHazirlikSuresi: yemekHazirlikSuresi,yemekKisiSayisi: yemekKisiSayisi,yemekMalzemeler: yemekMalzemeler,yemekPisirmeSuresi: yemekPisirmeSuresi, yemekTarif: yemekTarif)
                                self.yemekListesi.append(yemek)
                            }
                            group.leave()
                            self.collectionView.reloadData()
                        }
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    
    func userData(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
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
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "profilToDetay" {
            let indeks = sender as? Int
            let gidilecekVC = segue.destination as! TarifDetayVC
            gidilecekVC.yemek = yemekListesi[indeks!]
        }
        
        
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
        cell.yemekResim.sd_setImage(with: URL(string: yemek.yemekResim))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "profilToDetay", sender: indexPath.row)
    }
}









extension ProfilVC{
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
}
