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
        
        self.locationManager.delegate = self
    }
    
    
    @IBAction func clickGetLocation(_ sender: UIButton) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        case .authorizedWhenInUse:
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
        default:
            print("Default")
        }
    }
    
}

extension LocationViewController: CLLocationManagerDelegate {
    
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
