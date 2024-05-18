//  ProfilVC.swift
//  Yemeklerim
//  Created by Fırat İlhan on 24.04.2024.

import UIKit
import FirebaseFirestore
import FirebaseAuth

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

        
        
//        let yemek1 = Yemekler(yemekId: "1", yemekAd: "Mercimek Çorbası", yemekKisiSayisi: "2 kişilik", yemekAciklama: "Açıklama", yemekHazirlikSuresi: "hazırlık süresi", yemekTarif: "tarif", yemekResim: "çorba", yemekPisirmeSuresi: "20 dakika", yemekMalzemeler: "malzemeler", kategori: Kategoriler(kategoriId: "1", kategoriAd: "Çorbalar"), kullanici: Kullanicilar(kullaniciId: "1", kullaniciAd: "fıratilhan08", kullaniciAdSoyad: "fırat ilhan", kullaniciFoto: "f", kullaniciAciklama: "öğrenci", kullaniciSifre: "111111", kullaniciEmail: "firatilhan008@gmail.com"))
//        yemekListesi.append(yemek1)
  
        
        
        // UILabel oluşturma
        emptyMessageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        emptyMessageLabel.text = "Henüz tarif yüklemediniz"
        emptyMessageLabel.textColor = .gray
        emptyMessageLabel.textAlignment = .center
        emptyMessageLabel.font = UIFont.systemFont(ofSize: 20)
        
        collectionView.backgroundView = emptyMessageLabel
        
        // Verileri kontrol edin ve UILabel'in görünürlüğünü ayarlayın
        checkData()
        
        
    }
    func checkData() {
        if yemekListesi.isEmpty {
            emptyMessageLabel.isHidden = false
        } else {
            emptyMessageLabel.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        userData()
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
        cell.yemekResim.image = UIImage(named: yemek.yemekResim!)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "profilToDetay", sender: indexPath.row)
        print("profil yemek detay tıklandı")

    }
    
    
}
