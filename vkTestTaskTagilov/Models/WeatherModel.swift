//
//  WeatherModel.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

struct WeatherResponseModel: Decodable {
    var cityName: String?
    let current: CurrentWeatherModel
    let daily: [DailyWeatherModel]
}

struct CurrentWeatherModel: Decodable {
    let dt: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let wind_speed: Double
    let weather: [WeatherDescriptionModel]
}

struct WeatherDescriptionModel: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct DailyWeatherModel: Decodable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: TemperatureModel
    let pressure: Int
    let humidity: Int
    let wind_speed: Double
    let weather: [WeatherDescriptionModel]
}

struct TemperatureModel: Decodable {
    let min: Double
    let max: Double
}
