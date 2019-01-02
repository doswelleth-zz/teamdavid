//
//  MapViewController.swift
//  TeamDavid-Sprint-11
//
//  Created by David Doswell on 12/31/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    private let locationManager = CLLocationManager()
    private var userTrackingButton: MKUserTrackingButton!
    
    private let experienceController = ExperienceController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            NSLog("Please permit access to use your location")
        }
        
        userTrackingButton = MKUserTrackingButton(mapView: mapView)
        userTrackingButton.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(userTrackingButton)
        userTrackingButton.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 20).isActive = true
        userTrackingButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -20).isActive = true
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "ExperienceAnnotationView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    private func updateViews() {
        let annotations = mapView.annotations
        
        mapView.removeAnnotations(annotations)
        mapView.addAnnotations(experienceController.experiences)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "ExperienceAnnotationView") as! MKMarkerAnnotationView
        annotationView.markerTintColor = .gray
        annotationView.glyphTintColor = .black
        
        return annotationView
    }
    
}
