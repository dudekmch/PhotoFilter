//
//  DispatchQueue.swift
//  photo
//
//  Created by Pawel Dudek on 12.02.2018.
//  Copyright © 2018 cookieIT. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    static var camera: DispatchQueue {
        return DispatchQueue(label: "Camera", qos: .userInitiated)
    }
}
