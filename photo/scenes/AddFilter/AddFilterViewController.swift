import UIKit

private let reuseIdentifier = "photoCell"

protocol FiltersHandler {
    func didSelect(_ filter: Any)
    var filtersCollectionView: UICollectionView? {get set}
}

protocol AddFilterDisplayLogic: class {
}

protocol AddFilterViewHandler: class {
    var photosCollectionView: UICollectionView? {get set}
    var filtersContainerView: UIView? {get set}
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
//            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    
    private func buildInterface(){
        guard let interfaceBuilder = self.interfaceBuilder else { return }
        interfaceBuilder.configureView()
        filtersContainerView = interfaceBuilder.buildFiltersContainerView()
        photosCollectionView = interfaceBuilder.buildCollectionView()
        interfaceBuilder.buildFiltersHandler()
        interfaceBuilder.setupAutolayout()
    }
    
    func didSelect(_ filter: Any){}
    
}

extension AddFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cg = CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.width, height: 40)
        let cell = UICollectionViewCell.init(frame: cg)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
}
