//
//  WeatherModel.swift
//  WheatherApp
//
//  Created by Admin on 28.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct WeatherInformation: Decodable {
    var name: String?
    var main: MainCityInformation?
    var clouds: CloudsCityInformation?
    var wind: WindCityInformation?
}

struct MainCityInformation: Decodable {
    var temp: Double?
}

struct CloudsCityInformation: Decodable {
    var all: Int?
}

struct WindCityInformation: Decodable {
    var speed: Double?
}

struct WeatherDescriptionInSearchingCityContainer: Decodable {
    var weather: [WeatherInSearchingCity]
}

struct WeatherInSearchingCity: Decodable {
    var description: String
}

