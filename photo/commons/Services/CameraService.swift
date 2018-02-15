//
//  CameraService.swift
//  photo
//
//  Created by Pawel Dudek on 12.02.2018.
//  Copyright © 2018 cookieIT. All rights reserved.
//

import UIKit
import AVFoundation

class CameraService {
    
    private var session: AVCaptureSession?
    private var frontCamera: AVCaptureDevice?
    private var backCamera: AVCaptureDevice?
    private var frontCameraInput: AVCaptureDeviceInput?
    private var backCameraInput: AVCaptureDeviceInput?
    private var cameraOutput: AVCapturePhotoOutput?
    
    private var currentPosition: CameraPosition!
    func setup(callback: @escaping(Error?)->()) {
        func createSession(){
            self.session = AVCaptureSession()
        }
        func configureCaptureDevices() throws {
            let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
            let devices = session.devices.flatMap { $0 }
            guard devices.count > 0 else {
                throw CameraError.noValidDevices
            }
            for camera in devices {
                if camera.position == .front {
                    self.frontCamera = camera
                }
                if camera.position == .back {
                     self.backCamera = camera
                }
            }
        }
        func configureDeviceInput() throws {
            guard let session = self.session else {
                throw CameraError.captureSessionIsMissing
            }
            if let frontCamera = self.frontCamera {
                self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
            }
            if let backCamera = self.backCamera {
                self.backCameraInput = try AVCaptureDeviceInput(device: backCamera)
                if session.canAddInput(self.backCameraInput!) {
                   session.addInput(self.backCameraInput!)
                } else {
                    throw CameraError.invalidDevice
                }
                self.currentPosition = .back
            } else {
                throw CameraError.invalidDevice
            }
        }
        func configureDeviceOutput() throws {
            guard let session = self.session else {
                throw CameraError.captureSessionIsMissing
            }
            self.cameraOutput = AVCapturePhotoOutput()
            self.cameraOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])], completionHandler: nil)
            if session.canAddOutput(self.cameraOutput!){
                session.addOutput(self.cameraOutput!)
            }
            session.startRunning()
        }
        
        DispatchQueue.camera.async {
            var setupError: Error?
            do {
                createSession()
                try configureCaptureDevices()
                try configureDeviceInput()
                try configureDeviceOutput()
            } catch {
                setupError = error
            }
            DispatchQueue.main.async {
                callback(setupError)
            }
        }
    }
}

extension CameraService {
    
    enum CameraError: Swift.Error {
        case noValidDevices
        case captureSessionIsMissing
        case invalidDevice
    }
    
    enum CameraPosition {
        case front
        case back
    }
}
