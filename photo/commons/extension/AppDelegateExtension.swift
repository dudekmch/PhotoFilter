//
//  AppDelegateExtension.swift
//  photo
//
//  Created by Pawel Dudek on 12.02.2018.
//  Copyright © 2018 cookieIT. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    func setupInitialViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let initialViewController = TakeAPhotoViewController()
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
}
