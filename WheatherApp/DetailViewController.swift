////
////  DetailViewController.swift
////  WheatherApp
////
////  Created by Admin on 28.05.2020.
////  Copyright © 2020 Admin. All rights reserved.
////
//
//import UIKit
//
//class DetailedViewController: UIViewController {
//    //var data = WeatherInformation()
//    
//    
//    //let tempInString = String(tempInInt)
//    @IBOutlet weak var cityNameLabel: UILabel!
//    @IBOutlet weak var cityTemperatureLabel: UILabel!
//    @IBOutlet weak var cityTemperature: UILabel!
//    @IBOutlet weak var cityWeatherLabel: UILabel!
//    @IBOutlet weak var cityWeather: UILabel!
//    @IBOutlet weak var cityWindLabel: UILabel!
//    @IBOutlet weak var cityWind: UILabel!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        showDetailedInformation()
//    }
//    
//    func convertDoubleInString (somethingInDouble: Double) -> String {
//        var temperatureInString = String(Int(somethingInDouble))
//        return temperatureInString
//    }
//    
//    func convertIntInstring(somethingInInt: Int) -> String {
//        var windInInt = somethingInInt
//        var windInString = String(windInInt)
//        return windInString
//    }
//    
//    
//    func showDetailedInformation() {
//        cityNameLabel.text = data.name
//        cityTemperatureLabel.text = "Temperature"
//        cityTemperature.text = convertDoubleInString(somethingInDouble: ((data.main?.temp)! - 273.15)) + " C"
//        cityWeatherLabel.text = "Clouds"
//        cityWeather.text = convertIntInstring(somethingInInt: (data.clouds?.all)!) + " %"
//        cityWindLabel.text = "Wind"
//        cityWind.text = convertDoubleInString(somethingInDouble: (data.wind?.speed)!) + " m/s"
//    }
//}
