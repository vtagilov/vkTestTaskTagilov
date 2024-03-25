//
//  LocationManager.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

import CoreLocation
import MapKit

final class LocationManager: NSObject {
    private let geocoder = CLGeocoder()
    private var locationManager: CLLocationManager
    private var isWaitingAuthorization = false
    
    var lastLocation: Location!
    var locationDeterminedCompletion: ((_ location: Location) -> Void)!
    var locationErrorCompletion: ((_ error: NetworkError) -> Void)!
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func fetchDeviceLocation() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = locationManager.location else {
                return
            }
            fetchCityNameLocation(location) { location in
                self.locationDeterminedCompletion(location)
            }
        default:
            isWaitingAuthorization = true
            self.locationErrorCompletion(.invalidLocation)
        }
    }
    func fetchLocationFromName(_ locationName: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = locationName
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if error != nil {
                self.locationErrorCompletion(.noInternetConnectivity)
                return
            }
            guard let placemark = response?.mapItems.first?.placemark else {
                self.locationErrorCompletion(.invalidLocation)
                return
            }
            guard let cityName = placemark.locality else {
                let location = Location(placemark.coordinate, "")
                self.locationDeterminedCompletion(location)
                return
            }
            let location = Location(placemark.coordinate, cityName)
            self.locationDeterminedCompletion(location)
        }
    }
    
    private func fetchCityNameLocation(_ location: CLLocation, completion: @escaping (Location) -> ()) {
        geocoder.reverseGeocodeLocation(location) { placeMarks, error in
            if error != nil {
                self.locationErrorCompletion(.noInternetConnectivity)
                completion(Location(location.coordinate, ""))
                return
            }
            guard let cityName = placeMarks?.first?.locality else {
                completion(Location(location.coordinate, ""))
                return
            }
            let location = Location(location.coordinate, cityName)
            completion(location)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if isWaitingAuthorization {
            switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                fetchDeviceLocation()
                isWaitingAuthorization = false
            default:
                break
            }
        }
    }
}
