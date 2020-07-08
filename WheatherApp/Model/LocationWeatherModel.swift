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
//    var main: MainCityInformation?
//    var clouds: CloudsCityInformation?
//    var wind: WindCityInformation?
}

struct CurrentCityWeather: Decodable {
    var temp: Double?
    //var wind_speed: Double?
}
//
//struct CloudsCityInformation: Decodable {
//    var all: Int?
//}
//
//struct WindCityInformation: Decodable {
//    var speed: Double?
//}
