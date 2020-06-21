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
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    @IBOutlet weak var cityTemperature: UILabel!
    @IBOutlet weak var cityWeatherLabel: UILabel!
    @IBOutlet weak var cityWeather: UILabel!
    @IBOutlet weak var cityWindLabel: UILabel!
    @IBOutlet weak var cityWind: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDetailedInformation()
        // Do any additional setup after loading the view.
    }
    
    func showDetailedInformation() {
        cityNameLabel.text = data.name
        cityTemperatureLabel.text = "Temperature"
        
        print(data, 11111)
    }
    
}
