//
//  LocationViewController.swift
//  Picker Permission
//
//  Created by Yusuf Saifudin on 04/08/23.
//

import UIKit
import CoreLocation

@MainActor
class LocationViewController: UIViewController {
    
    @IBOutlet weak var labelLatLng: UILabel!
    @IBOutlet weak var buttonGetLocation: UIButton!
    
    private var locationManager: CLLocationManager!
    private var locationTimeout: Task<Void, Never>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Location"
        self.labelLatLng.text = ""
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
    }
    
    
    @IBAction func clickGetLocation(_ sender: UIButton) {
        startButtonLoading(sender)

        switch locationManager.authorizationStatus {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            self.locationManager.stopUpdatingLocation()
            stopButtonLoading()
            print("LocationViewController # Restricted or Denied")
        case .authorizedWhenInUse, .authorizedAlways:
            self.checkServiceLocation()
        default:
            self.locationManager.stopUpdatingLocation()
            stopButtonLoading()
            print("LocationViewController # Default")
        }
    }
    
    private func startButtonLoading(_ button: UIButton) {
        button.isEnabled = false
        var config = button.configuration ?? .filled()
        config.showsActivityIndicator = true
        config.title = "Loading..."
        button.configuration = config
    }
    
    private func stopButtonLoading() {
        buttonGetLocation.isEnabled = true
        var config = buttonGetLocation.configuration ?? .filled()
        config.showsActivityIndicator = false
        config.title = "Get Location"
        buttonGetLocation.configuration = config
    }
    
    private func checkServiceLocation() {
        Task.detached(priority: .background) {
            let isEnabled = CLLocationManager.locationServicesEnabled()
            await MainActor.run {
                guard isEnabled else {
                    self.stopButtonLoading()
                    self.labelLatLng.text = "Location services disabled"
                    return
                }

                let status = self.locationManager.authorizationStatus
                switch status {
                case .authorizedWhenInUse, .authorizedAlways:
                    self.locationManager.startUpdatingLocation()
                    self.startLocationTimeout()
                case .restricted, .denied:
                    self.locationManager.stopUpdatingLocation()
                    self.stopButtonLoading()
                    self.labelLatLng.text = "Location access denied"
                case .notDetermined:
                    self.stopButtonLoading()
                default:
                    self.locationManager.stopUpdatingLocation()
                    self.stopButtonLoading()
                }
            }
        }
    }
    
    private func startLocationTimeout() {
        locationTimeout?.cancel()
        locationTimeout = Task {
            try? await Task.sleep(for: .seconds(15))
            guard !Task.isCancelled else { return }
            locationManager.stopUpdatingLocation()
            stopButtonLoading()
            labelLatLng.text = "Location request timed out"
            print("LocationViewController # Location request timed out")
        }
    }
    
    private func stopLocationTimeout() {
        locationTimeout?.cancel()
        locationTimeout = nil
    }
    
}

extension LocationViewController: @preconcurrency CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard buttonGetLocation.configuration?.showsActivityIndicator == true else { return }

        let status = manager.authorizationStatus
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            self.checkServiceLocation()
        case .restricted, .denied:
            self.locationManager.stopUpdatingLocation()
            self.stopButtonLoading()
            self.labelLatLng.text = "Location access denied"
        case .notDetermined:
            self.stopButtonLoading()
        default:
            self.stopButtonLoading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        stopLocationTimeout()
        stopButtonLoading()
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            self.labelLatLng.text = "\(lat),\(lng)"
        }
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        stopLocationTimeout()
        stopButtonLoading()
        self.labelLatLng.text = "Failed to get location"
        print("LocationViewController # error \(error.localizedDescription)")
    }
    
}
