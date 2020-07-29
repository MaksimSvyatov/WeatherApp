//
//  LocationWeatherModel.swift
//  WheatherApp
//
//  Created by Admin on 06.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct LocationWeatherModel: Decodable {
    var name: String?
    var main: CurrentCityWeather?
    var wind: WindInCurrentCity?
}

struct CurrentCityWeather: Decodable {
    var temp: Double?
}

struct WindInCurrentCity: Decodable {
    var speed: Double?
}



struct WeatherDescriptionContainer: Decodable {
    var weather: [Weather]
}

struct Weather: Decodable {
    var description: String
}

