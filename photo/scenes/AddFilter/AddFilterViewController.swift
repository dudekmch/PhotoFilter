import UIKit

private let reuseIdentifier = "photoCell"

protocol FiltersHandler {
    func didSelect(_ filter: Any)
    var filtersCollectionView: UICollectionView? { get set }
}

protocol AddFilterDisplayLogic: class {
}

protocol AddFilterViewHandler: class {
    var photosCollectionView: UICollectionView? { get set }
    var filtersContainerView: UIView? { get set }
}

class AddFilterViewController: UIViewController, AddFilterDisplayLogic, AddFilterViewHandler, FiltersHandler {

    var interactor: AddFilterBusinessLogic?
    var router: (NSObjectProtocol & AddFilterRoutingLogic & AddFilterDataPassing)?
    var interfaceBuilder: AddFilterViewProvider?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = AddFilterInteractor()
        let presenter = AddFilterPresenter()
        let router = AddFilterRouter()
        let interfaceBuilder = AddFilterInterfaceBuilder(of: viewController)
        viewController.interactor = interactor
        viewController.router = router
        viewController.interfaceBuilder = interfaceBuilder
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Properties
    var photosCollectionView: UICollectionView?
    var filtersContainerView: UIView?
    var filtersCollectionView: UICollectionView?

    // MARK: View lifecycle

    override func loadView() {
        self.view = UIView()
        buildInterface()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let collectionView = photosCollectionView {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("landscape")
            photosCollectionView?.reloadData()
            
        } else {
            print("portrait")
            photosCollectionView?.reloadData()
        }
    }

    private func buildInterface() {
        guard let interfaceBuilder = self.interfaceBuilder else { return }
        interfaceBuilder.configureView()
        filtersContainerView = interfaceBuilder.buildFiltersContainerView()
        photosCollectionView = interfaceBuilder.buildCollectionView()
        interfaceBuilder.buildFiltersHandler()
        interfaceBuilder.setupAutolayout()
    }

    func didSelect(_ filter: Any) { }

}

extension AddFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .white
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        if let view = photosCollectionView{
            let layaut = view.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWitdhIncludingSpacing = view.bounds.width + layaut.minimumLineSpacing

            var offset = targetContentOffset.pointee
            let index = offset.x / cellWitdhIncludingSpacing
            let roundedIndex = round(index)

            offset = CGPoint.init(x: roundedIndex * cellWitdhIncludingSpacing, y: 0)
            targetContentOffset.pointee = offset
        }
    }

}
