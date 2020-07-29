//
//  DetailViewController.swift
//  WheatherApp
//
//  Created by Admin on 28.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    var data = WeatherInformation()
    var data1: WeatherDescriptionInSearchingCityContainer?
    
    
    //let tempInString = String(tempInInt)
    
    @IBOutlet weak var searchingCityName: UILabel!
    @IBOutlet weak var searchingCityWeatherDescription: UILabel!
    @IBOutlet weak var searchingCityWeatherDescriptionImage: UIImageView!
    @IBOutlet weak var searchingCityTemperature: UILabel!
    @IBOutlet weak var searchingCityWindSpeed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDetailedInformation()
    }
    
    func convertDoubleInString (somethingInDouble: Double) -> String {
        var temperatureInString = String(Int(somethingInDouble))
        return temperatureInString
    }
    
    func convertIntInstring(somethingInInt: Int) -> String {
        var windInInt = somethingInInt
        var windInString = String(windInInt)
        return windInString
    }
    
    
    func showDetailedInformation() {
        searchingCityName.text = data.name
        self.searchingCityWeatherDescription.text = data1?.weather.first?.description
        
        searchingCityTemperature.text = convertDoubleInString(somethingInDouble: ((data.main?.temp)! - 273.15)) + " C"
        self.searchingCityWeatherDescriptionImage.image = UIImage(named: "Cloudy")
        searchingCityWindSpeed.text = convertDoubleInString(somethingInDouble: (data.wind?.speed)!) + " m/s"
    }
}
