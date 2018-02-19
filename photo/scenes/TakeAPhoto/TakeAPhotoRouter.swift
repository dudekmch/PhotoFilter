//
//  TakeAPhotoRouter.swift
//  photo
//
//  Created by Pawel Dudek on 12.02.2018.
//  Copyright (c) 2018 cookieIT. All rights reserved.
//

import UIKit

@objc protocol TakeAPhotoRoutingLogic {
    func routeToAddFilterScene()
}

protocol TakeAPhotoDataPassing {
    var dataStore: TakeAPhotoDataStore? { get }
}

class TakeAPhotoRouter: NSObject, TakeAPhotoRoutingLogic, TakeAPhotoDataPassing {
    weak var viewController: TakeAPhotoViewController?
    var dataStore: TakeAPhotoDataStore?
    
    // MARK: Routing
    
    func routeToAddFilterScene() {
        let con = AddFilterViewController()
        
        // con.router.database.images = self.datastore.images
        
        self.viewController?.show(con, sender: nil)
    }
    
    
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: TakeAPhotoViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: TakeAPhotoDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
