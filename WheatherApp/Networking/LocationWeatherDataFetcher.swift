//
//  LocationWeatherDataFetcher.swift
//  WheatherApp
//
//  Created by Admin on 06.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation


class LocationWeatherDataFetcher {
   
   let networkService = NetworkManager()
   
   func fetchCities(urlString: String, response: @escaping (LocationWeatherModel?) -> Void) {
       networkService.searchCity(urlString: urlString) { (result) in
           switch result {
           case .success(let data):
               do {
                   let weather = try JSONDecoder().decode(LocationWeatherModel.self, from: data)
                   
                   response(weather)
               } catch let jsonError {
                   print("Failed to parse JSON", jsonError)
               }
           case .failure(let error):
               response(nil)
           }
       }
   }
    

    func fetchCurrentCityConditions(urlString: String, response: @escaping (WeatherDescriptionContainer?) -> Void) {
        networkService.searchCity(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(WeatherDescriptionContainer.self, from: data)
                    
                    response(weather)
                } catch let jsonError {
                    print("Failed to parse JSON", jsonError)
                }
            case .failure(let error):
                response(nil)
            }
        }
    }
}
