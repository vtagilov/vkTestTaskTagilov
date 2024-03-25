//
//  LocationSearchBar.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 21.03.2024.
//

import UIKit

protocol LocationSearchBarDelegate: AnyObject {
    func didSelectLocation(_ location: String)
}
extension SearchViewController: LocationSearchBarDelegate {
    func didSelectLocation(_ location: String) {
        viewModel.locationSaver.addQuery(location, .recent)
        viewModel.locationWasSelected(location)
    }
}

final class LocationSearchBar: UISearchBar, UISearchBarDelegate {
    weak var locationDelegate: LocationSearchBarDelegate?
    
    init() {
        super.init(frame: .zero)
        setupSearchBar()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self
        self.placeholder = "Search Location"
        self.searchBarStyle = .minimal
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.textColor = UIColor.white
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        searchBar.resignFirstResponder()
        locationDelegate?.didSelectLocation(searchText)
    }
}
