//
//  TakeAPhotoViewController.swift
//  photo
//
//  Created by Pawel Dudek on 12.02.2018.
//  Copyright (c) 2018 cookieIT. All rights reserved.
//

import UIKit

protocol TakeAPhotoDisplayLogic: class {
}

protocol TakeAPhotoViewHandler: class {
    var takeAPhotoButton: UIButton! {get set}
    var changeCameraButton: UIButton! {get set}
    var previewView: UIView! {get set}
    var backButton: UIButton! {get set}
    var aButton: UIButton! {get set}
    var cButton: UIButton! {get set}
}

class TakeAPhotoViewController: UIViewController, TakeAPhotoDisplayLogic, TakeAPhotoViewHandler {
    var interactor: TakeAPhotoBusinessLogic?
    var router: (NSObjectProtocol & TakeAPhotoRoutingLogic & TakeAPhotoDataPassing)?
    var interfaceBuilder: TakeAPhotoViewProvider?
    
    
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
        let interactor = TakeAPhotoInteractor()
        let presenter = TakeAPhotoPresenter()
        let router = TakeAPhotoRouter()
        let interfaceBuilder = TakeAPhotoInterfaceBuilder(of: viewController)
        viewController.interactor = interactor
        viewController.router = router
        viewController.interfaceBuilder = interfaceBuilder
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Properties
    
    var takeAPhotoButton: UIButton!
    var changeCameraButton: UIButton!
    var backButton: UIButton!
    var cButton: UIButton!
    var aButton: UIButton!
    var previewView: UIView!
    
    // MARK: View lifecycle
    
    override func loadView() {
        self.view = UIView()
        buildInterface()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Private methods
    
    private func buildInterface() {
        guard let interfaceBuilder = self.interfaceBuilder else { return }
        
        interfaceBuilder.configureView()
        takeAPhotoButton = interfaceBuilder.buildTakeAPhotoButton()
        changeCameraButton = interfaceBuilder.buildChangeCameraButton()
        aButton = interfaceBuilder.buildChangeCameraButton()
        cButton = interfaceBuilder.buildChangeCameraButton()
        backButton = interfaceBuilder.buildTakeAPhotoButton()
        
        previewView = interfaceBuilder.buildPreviewView()
        
        interfaceBuilder.setupAutolayout()
        
        takeAPhotoButton.addTarget(self, action: #selector(takeAPhoto), for: .touchUpInside)
    }
    
    @objc private func takeAPhoto() {
        let request = TakeAPhoto.CaptureImage.Request()
        interactor?.captureImage(request)
    }
    
}

extension TakeAPhotoViewHandler where Self: UIViewController {
    func asViewController()->UIViewController {
        return self as UIViewController
    }
}
