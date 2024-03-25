//
//  LocationModel.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

import CoreLocation

struct Location: Equatable {
    let longitude: Double
    let latitude: Double
    let cityName: String
    
    init(_ CLCoordinates: CLLocationCoordinate2D, _ cityName: String) {
        latitude = CLCoordinates.latitude
        longitude = CLCoordinates.longitude
        self.cityName = cityName
    }
}
