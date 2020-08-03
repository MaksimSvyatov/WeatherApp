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
        setFonts()
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
    
    func setFonts() {
        searchingCityName.font = UIFont(name: "RobotoCondensed-Bold", size: 30)
        searchingCityName.textColor = .white
        searchingCityWeatherDescription.font = UIFont(name: "RobotoCondensed-Bold", size: 15)
        searchingCityWeatherDescription.textColor = .white
        searchingCityTemperature.font = UIFont(name: "RobotoCondensed-Bold", size: 25)
        searchingCityTemperature.textColor = .white
        searchingCityWindSpeed.font = UIFont(name: "RobotoCondensed-Bold", size: 15)
        searchingCityWindSpeed.textColor = .white
    }
    
//    func setBlurEffectForBackground() {
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        backgroundImageView.addSubview(blurEffectView)
//    }
    
    func showDetailedInformation() {
        searchingCityName.text = data.name
        self.searchingCityWeatherDescription.text = data1?.weather.first?.description
        searchingCityTemperature.text = convertDoubleInString(somethingInDouble: ((data.main?.temp)! - 273.15)) + " C"
        
        if self.data1?.weather.first!.description == "few clouds" {
            self.searchingCityWeatherDescriptionImage.image = UIImage(named: "Cloudy")
        } else if self.data1?.weather.first!.description == "overcast clouds" {
            self.searchingCityWeatherDescriptionImage.image = UIImage(named: "Overcast")
        }
        else {
            self.searchingCityWeatherDescriptionImage.image = UIImage(named: "Sunny")
        }
        
        searchingCityWindSpeed.text = convertDoubleInString(somethingInDouble: (data.wind?.speed)!) + " m/s"
    }
}
