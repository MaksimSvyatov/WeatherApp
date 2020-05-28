//
//  NetworkManagerViewController.swift
//  WheatherApp
//
//  Created by Admin on 28.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol SearchServiceProtocol {
    func searchCity(urlString: String, completion: @escaping (Result<WeatherInformation, Error>) -> Void)
}

class NetworkManagerViewController: SearchServiceProtocol {
    
    func searchCity(urlString: String, completion: @escaping (Result<WeatherInformation, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                do {
                    let weather = try JSONDecoder().decode(WeatherInformation.self, from: data)
                    
                    completion(.success(weather))
                } catch let jsonError {
                    print("Failed to parse JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
}
