//
//  AddFilterRouter.swift
//  photo
//
//  Created by Pawel Dudek on 13.02.2018.
//  Copyright (c) 2018 cookieIT. All rights reserved.
//

import UIKit

@objc protocol AddFilterRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol AddFilterDataPassing {
    var dataStore: AddFilterDataStore? { get }
}

class AddFilterRouter: NSObject, AddFilterRoutingLogic, AddFilterDataPassing {
    weak var viewController: AddFilterViewController?
    var dataStore: AddFilterDataStore?
    
    // MARK: Routing
    
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
    
    //func navigateToSomewhere(source: AddFilterViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: AddFilterDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
