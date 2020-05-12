//
//  FirstViewController.swift
//  fleet-ios
//
//  Created by Muhammad Hilmy Fauzi on 12/05/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import MapKit

class FleetController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeter: Double = 1_000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavBar()
        checkLocationServices()
        setupCardView()
    }

    func setupNavBar() {
        navigationItem.title = "Activity"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupCardView() {
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 30
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardView.layer.cornerRadius = 15
    }
    
        // Checking location services
        func checkLocationServices() {
            if CLLocationManager.locationServicesEnabled() {
                setupLocationManager()
                checkLocationAuthorization()
            } else {
                let alert = UIAlertController(title: "Warning", message: "Please turn on you location services", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                present(alert, animated: true)
            }
        }
        
        func setupLocationManager() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        func centerUserLocation() {
            if let location = locationManager.location?.coordinate {
                let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeter, longitudinalMeters: regionInMeter)
                mapView.setRegion(region, animated: true)
            }
        }
        
        // Check location authorization
        func checkLocationAuthorization() {
            
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                mapView.delegate = self
                mapView.showsUserLocation = true
                centerUserLocation()
                break
            case .authorizedAlways:
                break
            case .denied:
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                break
            case .restricted:
                break
            @unknown default:
                fatalError()
            }
        }
    
    
}

extension FleetController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeter, longitudinalMeters: regionInMeter)
            mapView.setRegion(region, animated: true)
        }
    }
    
}

