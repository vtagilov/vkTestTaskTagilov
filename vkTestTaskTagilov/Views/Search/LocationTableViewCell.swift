//
//  LocationTableViewCell.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 21.03.2024.
//

import UIKit

final class LocationTableViewCell: UITableViewCell {
    static let reuseIdentifier = "LocationTableViewCell"
    private let label = UILabel.createLabel()
    private let icon = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpUI()
    }
    
    func configureCell(_ query: (text: String, type: SavedLocationType)) {
        label.text = query.text
        switch query.type {
        case .favorite:
            icon.image = UIImage(systemName: "star")
        case .recent:
            icon.image = UIImage(systemName: "clock")
        }
    }
    func configureCellForMyLocation() {
        label.text = "Мое местоположение"
        icon.image = UIImage(systemName: "location")
    }
    
    private func setUpUI() {
        self.contentView.backgroundColor = .black
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .white
        label.textAlignment = .left
        configureConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension LocationTableViewCell {
    private func configureConstraints() {
        enum Constants {
            static let horizontalOffset = 16.0
        }
        contentView.addSubview(label)
        contentView.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: contentView.topAnchor),
            icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            icon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalOffset),
            icon.widthAnchor.constraint(equalTo: icon.heightAnchor, multiplier: 0.5),
            
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalOffset),
            label.trailingAnchor.constraint(equalTo: icon.leadingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
