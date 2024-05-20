//import FirebaseFirestore
//
//var kategoriListesi = [Kategoriler]()
//
//func fetchCategories() {
//    let db = Firestore.firestore()
//    
//    db.collection("kategoriler").getDocuments { (querySnapshot, error) in
//        if let error = error {
//            print("Error getting documents: \(error)")
//        } else {
//            self.kategoriListesi.removeAll()  // Önceki verileri temizle
//            for document in querySnapshot!.documents {
//                let data = document.data()
//                let id = document.documentID
//                let name = data["name"] as? String ?? "No Name"
//                let description = data["description"] as? String ?? "No Description"
//                
//                let kategori = Kategoriler(id: self.id, name: name, description: description)
//                self.kategoriListesi.append(kategori)
//            }
//            
//            // Veri çekildikten sonra UI'nizi güncelleyin
//            self.updateUI()
//        }
//    }
//}
//
//func updateUI() {
//    // Burada UI'nizi güncelleyebilirsiniz. Örneğin, bir tabloyu yeniden yükleyebilirsiniz.
//    // tableView.reloadData()
//}
