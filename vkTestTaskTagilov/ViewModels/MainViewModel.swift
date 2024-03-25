//
//  MainViewModel.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 19.03.2024.
//

import Foundation

final class MainViewModel {
    weak var coordinator: AppCoordinator!
    private let locationSaver = LocationSaver()
    private let networkManager = NetworkManager()
    private lazy var locationManager: LocationManager = {
        let locationManager = LocationManager()
        locationManager.locationDeterminedCompletion = { location in
            locationManager.lastLocation = location
            self.fetchWeather(location)
        }
        locationManager.locationErrorCompletion = { error in
            self.errorCompletion(error)
        }
        return locationManager
    }()
    
    var updateUICompletion: ((WeatherResponseModel) -> ())!
    var errorCompletion: ((NetworkError) -> ())!
    
    func getWeather(_ locationName: String? = nil) {
        if locationName == "" || locationName == nil{
            locationManager.fetchDeviceLocation()
            return
        }
        if let locationName = locationName {
            locationManager.fetchLocationFromName(locationName)
            return
        }
    }
    
    func updateWeather() {
        guard let location = locationManager.lastLocation else {
            getWeather()
            return
        }
        fetchWeather(location)
    }
    
    func goToSearchPage() {
        coordinator.goToSearchPage()
    }
    
    func addFavoritePlace(_ city: String) {
        locationSaver.addQuery(city, .favorite)
    }
    func isFavorite(_ city: String) -> Bool {
        return locationSaver.isFavorite(city)
    }
    
    private func fetchWeather(_ location: Location) {
        self.networkManager.fetchWeather(location) { responce in
            guard responce.error == nil else {
                self.errorCompletion(.noInternetConnectivity)
                return
            }
            guard let data = responce.data else {
                self.errorCompletion(.dataEmpty)
                return
            }
            guard var model = WeatherResponseParser.parseWeatherData(data) else {
                return
            }
            model.cityName = location.cityName
            self.updateUICompletion(model)
        }
    }
}
