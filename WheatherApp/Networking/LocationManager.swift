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

//        let status = CLLocationManager.authorizationStatus()
//        
//        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
//            return
//        }
//        
//        if(status == .notDetermined){
//            currentLocation.requestWhenInUseAuthorization()
//            
//            currentLocation.requestAlwaysAuthorization()
//            return
//        }
        
        currentLocation.requestLocation()
       // print(currentLocation.location?.coordinate, 1111111)

        //currentLocation.startUpdatingLocation()
    }
}
