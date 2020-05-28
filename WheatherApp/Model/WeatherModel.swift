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
    var main: ConcretCityInformation?
}

struct ConcretCityInformation: Decodable {
    var temp: Double?
}
