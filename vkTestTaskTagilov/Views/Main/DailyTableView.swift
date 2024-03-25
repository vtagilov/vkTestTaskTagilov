//
//  DailyTableView.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

import UIKit

class DailyTableView: UITableView {
    private var models = [DailyWeatherModel]()
    private var selectedRow: Int?
    
    init() {
        super.init(frame: .zero, style: .plain)
        setUpTableView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpTableView()
    }

    private func setUpTableView() {
        self.register(DailyCell.self, forCellReuseIdentifier: DailyCell.reuseIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .none
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
    }
    func setData(_ models: [DailyWeatherModel]) {
        self.models = models
        self.reloadData()
    }
}

extension DailyTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyCell.reuseIdentifier, for: indexPath) as? DailyCell else {
            return UITableViewCell()
        }
        let isSelected = indexPath.row == selectedRow
        cell.configureCell(models[indexPath.row], isSelected)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedRow {
            return 136
        }
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == selectedRow {
            selectedRow = nil
        } else {
            selectedRow = indexPath.row
        }
        tableView.reloadData()
    }
}
