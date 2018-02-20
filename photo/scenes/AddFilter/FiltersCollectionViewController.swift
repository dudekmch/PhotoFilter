
import UIKit

private let reuseIdentifier = "filterCell"

protocol FiltersDisplayLogic: class {
}

class FiltersCollectionViewController: UICollectionViewController, FiltersDisplayLogic {

    var delgate: FiltersHandler?
    
    override func loadView() {
        let layaut = UICollectionViewFlowLayout()
        layaut.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layaut)
        self.delgate?.filtersCollectionView = self.collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
    }

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .white
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delgate?.didSelect(1)
    }
}
