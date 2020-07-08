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
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var currentLatitude: Double = 0.000
    var currentLongitude: Double = 0.000
   //var currentLocationTemperatureInString = ""
    
    let networkDataFetcher = LocationWeatherDataFetcher()
    var weatherInConcreteCityViaLocation: LocationWeatherModel?
    var urlString: String = ""
    
    var currentLocation = LocationManager()
    //var data: WeatherInformation?
    
    @IBAction func getCurrentLocationByPressButton(_ sender: Any) {
        currentLocation.getCurrentLocation()
        guard let currentTemporaryLatitude = currentLocation.currentLocation.location?.coordinate.latitude else { return }
       guard let currentTemporaryLongitude = currentLocation.currentLocation.location?.coordinate.longitude else { return }
        //guard let currentTemporaryLocationTemperatureInString = weatherInConcreteCityViaLocation?.current?.temp else { return }
        
        
        print(currentTemporaryLongitude, currentTemporaryLatitude, weatherInConcreteCityViaLocation?.main?.temp
            , 111111)
        convertCoordinates()
               urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(currentLatitude)&lon=\(currentLongitude)&appid=8377ec5a9d2db6e91c9d69e92c0473ac"
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
    
    func convertCoordinates() -> (Double, Double) {
        //        guard let currentTemporaryLatitude = currentLocation.currentLocation.location?.coordinate.latitude else { return }
        //        guard let currentTemporaryLongitude = currentLocation.currentLocation.location?.coordinate.longitude else { return }

       currentLatitude = currentLocation.currentLocation.location!.coordinate.latitude
    
        currentLongitude = currentLocation.currentLocation.location!.coordinate.longitude
        
       // temperatureLabel.text = String(Int(weatherInConcreteCityViaLocation!.current!.temp!))
        
        
        //currentLocationTemperatureInString = String(Int(weatherInConcreteCityViaLocation!.current!.temp!))
        
        
                    //self.temperatureLabel.text = String(Int(weatherInConcreteCityViaLocation?.current?.temp ?? 0))
//        urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(currentLatitude)&lon=\(currentLongitude)&appid=8377ec5a9d2db6e91c9d69e92c0473ac"
        //print(currentLongitude, currentLatitude)
        return (currentLongitude, currentLatitude)
        
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
            self.cityNameLabel.text = weatherInConcreteCityViaLocation?.name
            self.temperatureLabel.text = String(Int(weatherInConcreteCityViaLocation?.main?.temp ?? 0) - 273)
            //"\(currentLocationTemperatureInString)" //currentLocationTemperatureInString
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}
