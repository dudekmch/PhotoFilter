
import UIKit

protocol AddFilterBusinessLogic {
    func getPhotos(request: AddFilter.Photos.Request)
}

protocol AddFilterDataStore {
    //var name: String { get set }
}

class AddFilterInteractor: AddFilterBusinessLogic, AddFilterDataStore {
    var presenter: AddFilterPresentationLogic?
    var worker: AddFilterWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func getPhotos(request: AddFilter.Photos.Request) {
        worker = AddFilterWorker()
        worker?.doSomeWork()
        
        let response = AddFilter.Photos.Response()
        presenter?.presentSomething(response: response)
    }
}
