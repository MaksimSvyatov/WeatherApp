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
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    var currentLatitude: Double = 0.000
    var currentLongitude: Double = 0.000
    var currentWeatherConditions: WeatherDescriptionContainer?
    var currentWeatherConditionsInSearchingCity: WeatherDescriptionInSearchingCityContainer?
    
    let networkDataFetcher = LocationWeatherDataFetcher()
let searchingCityDataFetcher = NetworkDataFetcher()
    var weatherInConcreteCityViaLocation: LocationWeatherModel?
    var urlString: String = ""
    
    var currentLocation = LocationManager()
    //var data: WeatherInformation?
    
    var data = WeatherInformation()
    
    @IBAction func getCurrentLocationByPressButton(_ sender: Any) {
        currentLocation.getCurrentLocation()
        
        guard let currentTemporaryLatitude = currentLocation.currentLocation.location?.coordinate.latitude else { return }
        guard let currentTemporaryLongitude = currentLocation.currentLocation.location?.coordinate.longitude else { return }
        
        urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(currentTemporaryLatitude)&lon=\(currentTemporaryLongitude)&appid=8377ec5a9d2db6e91c9d69e92c0473ac"
        
        networkDataFetcher.fetchCurrentCityConditions(urlString: urlString) { (searchResponse) in
            guard let searchResponse = searchResponse else { return }
            self.currentWeatherConditions = searchResponse
            self.weatherDescriptionLabel.text = self.currentWeatherConditions?.weather.first!.description
            print(self.currentWeatherConditions?.weather.startIndex, 222222)
        }
        
        networkDataFetcher.fetchCities(urlString: urlString) { (searchResponse) in
            guard let searchResponse = searchResponse else { return }
            self.weatherInConcreteCityViaLocation = searchResponse
            
            self.cityNameLabel.text = self.weatherInConcreteCityViaLocation?.name
            
            self.temperatureLabel.text = String(Int(self.weatherInConcreteCityViaLocation?.main?.temp ?? 0) - 273)
            self.windSpeedLabel.text = String(Int(self.weatherInConcreteCityViaLocation?.wind?.speed ?? 0)) + "m/s"
        }
        
        //print(currentTemporaryLongitude, currentTemporaryLatitude, weatherInConcreteCityViaLocation?.main?.temp!, currentWeatherConditions?.weather.first, 111111)
        convertCoordinates()
        //print(urlString)
        
    }
    
    func convertCoordinates() -> (Double, Double) {
        currentLatitude = currentLocation.currentLocation.location!.coordinate.latitude
        currentLongitude = currentLocation.currentLocation.location!.coordinate.longitude
        return (currentLongitude, currentLatitude)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLocation.currentLocation.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showWeatherInformationFromCitySearching()
    }
    
    func showWeatherInformationFromCitySearching() {
        
        searchingCityDataFetcher.fetchSearchingCityConditions (urlString: urlString) { (searchResponse) in
            guard let searchResponse = searchResponse else { return }
            self.currentWeatherConditionsInSearchingCity = searchResponse

        
        }
        self.weatherDescriptionLabel.text = currentWeatherConditionsInSearchingCity?.weather.first?.description//self.currentWeatherConditionsInSearchingCity?.weather.first!.description
        cityNameLabel.text = data.name
        
        temperatureLabel.text = String(Int(data.main?.temp ?? 0) - 273)
        windSpeedLabel.text = String(Int(data.wind?.speed ?? 0))
            + "m/s"
        print(currentWeatherConditionsInSearchingCity?.weather.first!.description, 55555)
    }
    
}

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            //            self.latitude.text = "\(currentLatitude)"
            //            self.longitude.text = "\(currentLongitude)"
            ////            self.cityNameLabel.text = weatherInConcreteCityViaLocation?.name
            //          weatherDescriptionLabel.text = currentWeatherConditions?.weather.first!.description
            ////            self.temperatureLabel.text = String(Int(weatherInConcreteCityViaLocation?.main?.temp ?? 0) - 273)
            ////            self.windSpeedLabel.text = String(Int(weatherInConcreteCityViaLocation?.wind?.speed ?? 0)) + "m/s"
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}
