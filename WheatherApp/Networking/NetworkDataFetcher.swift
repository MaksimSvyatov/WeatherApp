 //
 //  NetworkDataFetcher.swift
 //  WheatherApp
 //
 //  Created by Admin on 07.06.2020.
 //  Copyright © 2020 Admin. All rights reserved.
 //
 
 import Foundation
 
 class NetworkDataFetcher {
    
    let networkService = NetworkManager()
    
    func fetchCities(urlString: String, response: @escaping (WeatherInformation?) -> Void) {
        networkService.searchCity(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(WeatherInformation.self, from: data)
                    
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
