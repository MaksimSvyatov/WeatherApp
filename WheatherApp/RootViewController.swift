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
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var currentLatitude: Int = 0
    var currentLongitude: Int = 0
    
    let networkDataFetcher = LocationWeatherDataFetcher()
    var weatherInConcreteCityViaLocation: LocationWeatherModel? = nil
    var urlString: String = ""
    
    var currentLocation = LocationManager()
    //var data: WeatherInformation?
    
    @IBAction func getCurrentLocationByPressButton(_ sender: Any) {
        currentLocation.getCurrentLocation()
        guard let currentTemporaryLatitude = currentLocation.currentLocation.location?.coordinate.latitude else { return }
       guard let currentTemporaryLongitude = currentLocation.currentLocation.location?.coordinate.longitude else { return }
        
        convertCoordinates()
        print(urlString)
        networkDataFetcher.fetchCities(urlString: urlString) { (searchResponse) in
            guard let searchResponse = searchResponse else { return }
            self.weatherInConcreteCityViaLocation = searchResponse
            //        guard let cityName = searchResponse.name else { return }
            //        self.cityCount.append(cityName)
            //        self.tableView.reloadData()
        }
        //print(currentLatitude, 1111111)
    }
    
    func convertCoordinates() -> String {
        //        guard let currentTemporaryLatitude = currentLocation.currentLocation.location?.coordinate.latitude else { return }
        //        guard let currentTemporaryLongitude = currentLocation.currentLocation.location?.coordinate.longitude else { return }

       currentLatitude = Int(currentLocation.currentLocation.location!.coordinate.latitude)
    
        currentLongitude = Int(currentLocation.currentLocation.location!.coordinate.longitude)
        urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(currentLatitude)&lon=\(currentLongitude)&appid=8377ec5a9d2db6e91c9d69e92c0473ac"
        print(currentLongitude, currentLatitude)
        return urlString
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLocation.currentLocation.delegate = self
        //currentLocation.getCurrentLocation()
        //print(currentLocation.currentLocation.location?.coordinate, 1111111)
    }
}

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.latitude.text = "\(currentLatitude)"
            self.longitude.text = "\(currentLongitude)"
            cityNameLabel.text = weatherInConcreteCityViaLocation?.name
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}
