//
//  AddFilterPresenter.swift
//  photo
//
//  Created by Pawel Dudek on 13.02.2018.
//  Copyright (c) 2018 cookieIT. All rights reserved.
//

import UIKit

protocol AddFilterPresentationLogic {
    func presentSomething(response: AddFilter.Something.Response)
}

class AddFilterPresenter: AddFilterPresentationLogic {
    weak var viewController: AddFilterDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: AddFilter.Something.Response) {
        let viewModel = AddFilter.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
