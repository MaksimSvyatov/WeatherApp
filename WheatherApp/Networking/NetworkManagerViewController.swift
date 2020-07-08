//
//  NetworkManager.swift
//  WheatherApp
//
//  Created by Admin on 28.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

//protocol SearchServiceProtocol {
//    func searchCity(urlString: String, completion: @escaping (Result<Data, Error>) -> Void)
//}

class NetworkManager//: SearchServiceProtocol
{
    
    func searchCity(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error", error.localizedDescription)
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}
