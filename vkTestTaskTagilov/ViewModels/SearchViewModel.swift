//
//  SearchViewModel.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 21.03.2024.
//

import Foundation
import MapKit

final class SearchViewModel {
    weak var coordinator: AppCoordinator!
    internal let locationSaver = LocationSaver()
    
    func locationWasSelected(_ location: String) {
        coordinator.goBackToMainPage(location)
    }
}
