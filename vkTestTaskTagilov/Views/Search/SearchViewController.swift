//
//  SearchViewController.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 21.03.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    var viewModel: SearchViewModel!
    
    private let searchBar = LocationSearchBar()
    private let tableView = LocationsTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        setUpUI()
    }
    private func setUpUI() {
        self.view.backgroundColor = .black
        searchBar.locationDelegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SearchViewController {
    private func configureConstraints() {
        for subview in [searchBar, tableView] {
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
}
