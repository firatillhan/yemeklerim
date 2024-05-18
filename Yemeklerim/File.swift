import UIKit

class MyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var emptyMessageLabel: UILabel!
    var dataArray: [String] = [] // Veri kaynağınız

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
        if dataArray.isEmpty {
            emptyMessageLabel.isHidden = false
        } else {
            emptyMessageLabel.isHidden = true
        }
    }

    // CollectionView DataSource ve Delegate metotları
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        // Hücreyi yapılandırın
        return cell
    }
}
