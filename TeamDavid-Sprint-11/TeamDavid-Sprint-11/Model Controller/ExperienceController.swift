//
//  ExperienceController.swift
//  TeamDavid-Sprint-11
//
//  Created by David Doswell on 12/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation
import MapKit

class ExperienceController {
    
    static let shared = ExperienceController()
    
    var experiences: [Experience] = []
    
    func addExperience(title: String, image: UIImage, audioURL: URL, videoURL: URL, coordinate: CLLocationCoordinate2D) {
        let experience = Experience(title: title, image: image, audioURL: audioURL, videoURL: videoURL, coordinate: coordinate)
        experiences.append(experience)
    }
    
}
