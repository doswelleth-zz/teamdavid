//
//  CameraPreviewView.swift
//  TeamDavid-Sprint-11
//
//  Created by David Doswell on 12/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import AVFoundation

class CameraPreviewView: UIView {
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
