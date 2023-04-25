//
//  LocationManager.swift
//  RainOrShine
//
//  Created by Ethan Hess on 4/25/23.
//

import Foundation
import CoreLocation

//Used some of this tutorial for reference (https://www.hackingwithswift.com/quick-start/swiftui/how-to-read-the-users-location-using-locationbutton)

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LM error \(error.localizedDescription)")
    }
}




