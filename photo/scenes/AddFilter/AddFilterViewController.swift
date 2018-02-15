import UIKit

protocol AddFilterDisplayLogic: class {
    func displayPhotos(viewModel: AddFilter.Photos.ViewModel)
}

class AddFilterViewController: UIViewController, AddFilterDisplayLogic {
    
    var interactor: AddFilterBusinessLogic?
    var router: (NSObjectProtocol & AddFilterRoutingLogic & AddFilterDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var photoSlider: UISlider?

    private func getPhotos(){
        let request = AddFilter.Photos.Request()
        interactor?.getPhotos(request: request)
    }
    
     func displayPhotos(viewModel: AddFilter.Photos.ViewModel){
        
    }
}
