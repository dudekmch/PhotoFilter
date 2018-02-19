import UIKit

protocol AddFilterPresentationLogic {
}

class AddFilterPresenter: AddFilterPresentationLogic {
    weak var viewController: AddFilterDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: AddFilter.Photos.Response) {
        let viewModel = AddFilter.Photos.ViewModel()
    }
}
