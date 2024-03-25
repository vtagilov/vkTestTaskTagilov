//
//  LocationSaver.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 21.03.2024.
//

import Foundation

enum SavedLocationType {
    case recent
    case favorite
}

final class LocationSaver {
    var queries = [(text: String, type: SavedLocationType)]()
        
    init() {
        loadQueries()
    }
    
    func addQuery(_ text: String,_ type: SavedLocationType) {
        let index = queries.firstIndex(where: {
            $0.type == type && $0.text == text
        })
        switch type {
        case .favorite:
            if let index = index {
                queries.remove(at: index)
            } else {
                queries.insert((text, type), at: 0)
            }
        case .recent:
            if let index = index {
                queries.remove(at: index)
            }
            queries.insert((text, type), at: 0)
        }
        saveQueries()
    }
    
    func isFavorite(_ place: String) -> Bool {
        return queries.first(where: { $0.type == .favorite && $0.text == place }) != nil
    }
    
    private func saveQueries() {
        let favoriteQueries = queries.filter { $0.type == .favorite }.map { $0.text }
        let recentQueries = queries.filter { $0.type == .recent }.map { $0.text }
        UserDefaults.standard.set(recentQueries, forKey: "RecentQueries")
        UserDefaults.standard.set(favoriteQueries, forKey: "FavoriteQueries")
    }
    private func loadQueries() {
        if let savedQueries = UserDefaults.standard.stringArray(forKey: "FavoriteQueries") {
            queries.append(contentsOf: savedQueries.map { (text: $0, type: .favorite) })
        }
        if let savedQueries = UserDefaults.standard.stringArray(forKey: "RecentQueries") {
            queries.append(contentsOf: savedQueries.map { (text: $0, type: .recent) })
        }
    }
}
