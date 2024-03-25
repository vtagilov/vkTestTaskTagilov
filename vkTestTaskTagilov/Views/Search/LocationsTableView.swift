//
//  LocationsTableView.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 21.03.2024.
//

import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locationSaver.queries.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier, for: indexPath) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row == 0 {
            cell.configureCellForMyLocation()
            return cell
        }
        let item = viewModel.locationSaver.queries[indexPath.row - 1]
        cell.configureCell(item)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
        if indexPath.row == 0 {
            viewModel.locationWasSelected("")
            return
        }
        let location = viewModel.locationSaver.queries[indexPath.row - 1]
        viewModel.locationSaver.addQuery(location.text, .recent)
        viewModel.locationWasSelected(location.text)
    }
}

final class LocationsTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .grouped)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
