//
//  NetworkManager.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

import Foundation

final class NetworkManager {
    func fetchWeather(_ location: Location, completion: @escaping (NetworkResponce) -> ()) {
        guard let url = URL.getWeatherURL(location) else {
            completion(.init(error: .badURL))
            return
        }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.init(error: .noInternetConnectivity))
                return
            }
            guard let data = data else {
                completion(.init(error: .dataEmpty))
                return
            }
            completion(.init(data: data))
        }.resume()
    }
}
