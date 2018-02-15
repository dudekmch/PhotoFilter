//
//  TakeAPhotoInteractor.swift
//  photo
//
//  Created by Pawel Dudek on 12.02.2018.
//  Copyright (c) 2018 cookieIT. All rights reserved.
//

import UIKit

protocol TakeAPhotoBusinessLogic {
    func captureImage(_ request: TakeAPhoto.CaptureImage.Request)
}

protocol TakeAPhotoDataStore {
    //var name: String { get set }
}

class TakeAPhotoInteractor: TakeAPhotoBusinessLogic, TakeAPhotoDataStore {
    var presenter: TakeAPhotoPresentationLogic?
    var worker: TakeAPhotoWorker?
    //var name: String = ""
    
    func captureImage(_ request: TakeAPhoto.CaptureImage.Request) {
        
    }
}
