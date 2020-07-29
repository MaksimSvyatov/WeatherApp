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
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherDescriptionImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    var currentWeatherConditions: WeatherDescriptionContainer?
    var currentWeatherConditionsInSearchingCity: WeatherDescriptionInSearchingCityContainer?
    
    let networkDataFetcher = LocationWeatherDataFetcher()
    let searchingCityDataFetcher = NetworkDataFetcher()
    var weatherInConcreteCityViaLocation: LocationWeatherModel?
    var urlString: String = ""
    
    var currentLocation = LocationManager()
    
    @IBAction func getCurrentLocationByPressButton(_ sender: Any) {
        currentLocation.getCurrentLocation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLocation.currentLocation.delegate = self
        let status = CLLocationManager.authorizationStatus()
        
        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            return
        }
        
        if(status == .notDetermined){
            currentLocation.currentLocation.requestWhenInUseAuthorization()
            
            currentLocation.currentLocation.requestAlwaysAuthorization()
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            guard let currentTemporaryLatitude = currentLocation.currentLocation.location?.coordinate.latitude else { return }
            guard let currentTemporaryLongitude = currentLocation.currentLocation.location?.coordinate.longitude else { return }
            
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(currentTemporaryLatitude)&lon=\(currentTemporaryLongitude)&appid=8377ec5a9d2db6e91c9d69e92c0473ac"
            
            networkDataFetcher.fetchCurrentLocationCityWeather(urlString: urlString) { (searchResponse) in
                guard let searchResponse = searchResponse else { return }
                self.weatherInConcreteCityViaLocation = searchResponse
                self.cityNameLabel.text = self.weatherInConcreteCityViaLocation?.name
                self.temperatureLabel.text = String(Int(self.weatherInConcreteCityViaLocation?.main?.temp ?? 0) - 273)
                self.windSpeedLabel.text = String(Int(self.weatherInConcreteCityViaLocation?.wind?.speed ?? 0)) + "m/s"
            }
            
            networkDataFetcher.fetchCurrentCityConditions(urlString: urlString) { (searchResponse) in
                guard let searchResponse = searchResponse else { return }
                self.currentWeatherConditions = searchResponse
                self.weatherDescriptionLabel.text = self.currentWeatherConditions?.weather.first!.description
                self.weatherDescriptionImage.image = UIImage(named: "Cloudy")
                //print(self.currentWeatherConditions?.weather.startIndex, 222222)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}
