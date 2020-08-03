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
    @IBOutlet weak var backgroundImageView: UIImageView!
    
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
        //setBlurEffectForBackground()
        setFonts()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setFonts() {
        cityNameLabel.font = UIFont(name: "RobotoCondensed-Bold", size: 30)
        weatherDescriptionLabel.font = UIFont(name: "RobotoCondensed-Bold", size: 15)
        temperatureLabel.font = UIFont(name: "RobotoCondensed-Bold", size: 25)
        windSpeedLabel.font = UIFont(name: "RobotoCondensed-Bold", size: 15)
    }
    
    func setBlurEffectForBackground() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.addSubview(blurEffectView)
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
                self.temperatureLabel.text = String(Int(self.weatherInConcreteCityViaLocation?.main?.temp ?? 0) - 273)  + " C"
                self.windSpeedLabel.text = String(Int(self.weatherInConcreteCityViaLocation?.wind?.speed ?? 0)) + "m/s"
            }
            
            networkDataFetcher.fetchCurrentCityConditions(urlString: urlString) { (searchResponse) in
                guard let searchResponse = searchResponse else { return }
                self.currentWeatherConditions = searchResponse
                self.weatherDescriptionLabel.text = self.currentWeatherConditions?.weather.first!.description
                
                
                if self.currentWeatherConditions?.weather.first!.description == "few clouds" {
                    self.weatherDescriptionImage.image = UIImage(named: "Cloudy")
                } else if self.currentWeatherConditions?.weather.first!.description == "overcast clouds" {
                    self.weatherDescriptionImage.image = UIImage(named: "Overcast")
                }
                else {
                    self.weatherDescriptionImage.image = UIImage(named: "Sunny")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}
