//
//  RootViewController.swift
//  WheatherApp
//
//  Created by Admin on 03.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var latitude: UILabel!
    
        var latitude: Int?
        var longitude: Int?
    var currentLocation = LocationManager()
    //var data: WeatherInformation?
    
    @IBAction func getCurrentLocationByPressButton(_ sender: Any) {
        currentLocation.getCurrentLocation()
        //print(currentLocation.currentLocation.location?.coordinate, 1111111)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLocation.currentLocation.delegate = self
        currentLocation.getCurrentLocation()
        //print(currentLocation.currentLocation.location?.coordinate, 1111111)
    }
}

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.latitude.text = "\(location.coordinate.latitude)"
            self.longitude.text = "\(location.coordinate.longitude)"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}
