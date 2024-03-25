//
//  NetworkErrors.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

enum NetworkError: Error, Decodable {
    case unknown
    case badURL
    case invalidLocation
    case timeout
    case noInternetConnectivity
    case dataEmpty
    
    var description: String {
        switch self {
        case .unknown:
            return "Неизвестная ошибка"
        case .badURL, .dataEmpty:
            return "Сервис временно недоступен"
        case .noInternetConnectivity, .timeout:
            return "Отсутствует интернет соединение"
        case .invalidLocation:
            return "Неверное местоположение"
        }
    }
    
    var imageName: String {
        switch self {
        case .noInternetConnectivity:
            return "Network Error"
        default:
            return "Default Error"
        }
    }
}
