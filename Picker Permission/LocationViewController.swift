//
//  LocationViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
    
    @IBOutlet weak var labelLatLng: UILabel!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Location"
        self.labelLatLng.text = ""
    }
    
    
    @IBAction func clickGetLocation(_ sender: UIButton) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("LocationViewController # Restricted or Denied")
        case .authorizedWhenInUse, .authorizedAlways:
            self.checkServiceLocation()
        default:
            print("LocationViewController # Default")
        }
    }
    
    private func checkServiceLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
}

extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.checkServiceLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            DispatchQueue.main.async {
                self.labelLatLng.text = "\(lat),\(lng)"
            }
        }
    }
    
}
