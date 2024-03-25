//
//  DataParser.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

import Foundation

final class WeatherResponseParser {
    static func parseWeatherData(_ data: Data) -> WeatherResponseModel? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(WeatherResponseModel.self, from: data)
            return result
        } catch {
            return nil
        }
    }
}
