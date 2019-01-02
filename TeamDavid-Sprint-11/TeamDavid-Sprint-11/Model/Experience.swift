//
//  Experience.swift
//  TeamDavid-Sprint-11
//
//  Created by David Doswell on 12/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation
import MapKit

class Experience: NSObject, MKAnnotation {
    
    var title: String?
    var image: UIImage
    var audioURL: URL
    var videoURL: URL
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, image: UIImage, audioURL: URL, videoURL: URL, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.image = image
        self.audioURL = audioURL
        self.videoURL = videoURL
        self.coordinate = coordinate
    }
}
