//
//  URL.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

import Foundation

extension URL {
    enum WeatherApiConstants {
        static let coreUrl = "https://api.openweathermap.org/data/3.0/onecall?"
        static let apiKey = "2df4bb10947c619f892544faa9b92e74"
        static let options = "units=metric&lang=ru&exclude=minutely,hourly"
    }
    
    static func getWeatherURL(_ location: Location) -> URL? {
        let urlString = "\(WeatherApiConstants.coreUrl)lat=\(location.latitude)&lon=\(location.longitude)&appid=\(WeatherApiConstants.apiKey)&\(WeatherApiConstants.options)"
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
}


