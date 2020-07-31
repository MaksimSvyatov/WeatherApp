//
//  LocationManager.swift
//  WheatherApp
//
//  Created by Admin on 03.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager {
    
    var currentLocation = CLLocationManager()
    
    func getCurrentLocation (){
        currentLocation.requestLocation()
        currentLocation.startUpdatingLocation()
    }
}
