//
//  DailyCell.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

import UIKit

final class DailyCell: UITableViewCell {
    static let reuseIdentifier = "DailyTableView"
    private let dayOfWeekLabel = UILabel.createLabel(font: .systemFont(ofSize: TextSize.small))
    private let dayLabel = UILabel.createLabel(font: .systemFont(ofSize: TextSize.small))
    private let weatherIcon = UIImageView()
    private let minTempLabel = UILabel.createLabel()
    private let maxTempLabel = UILabel.createLabel()
    
    private let windIcon = UIImageView()
    private let windLabel = UILabel.createLabel(font: .systemFont(ofSize: TextSize.small))
    private let humidityIcon = UIImageView()
    private let humidityLabel = UILabel.createLabel(font: .systemFont(ofSize: TextSize.small))
    private let pressureIcon = UIImageView()
    private let pressureLabel = UILabel.createLabel(font: .systemFont(ofSize: TextSize.small))
    
    func configureCell(_ model: DailyWeatherModel, _ isSelected: Bool) {
        dayOfWeekLabel.text = DateFormatter.getDayOfWeek(unixTime: model.dt)
        dayLabel.text = DateFormatter.getDay(unixTime: model.dt)
        minTempLabel.text = "\(Int(model.temp.min.rounded()))"
        maxTempLabel.text = "\(Int(model.temp.max.rounded()))"
        weatherIcon.image = UIImage(named: model.weather.first!.icon)
        setUpUI()
        if isSelected {
            windLabel.text = "\(model.wind_speed) м/с"
            humidityLabel.text = "\(model.humidity)%"
            pressureLabel.text = "\(model.pressure) мм рт. ст."
            configureSelectedConstraints()
        } else {
            configureConstraints()
        }
        for subview in [windIcon, windLabel, humidityIcon, humidityLabel, pressureIcon, pressureLabel] {
            subview.isHidden = !isSelected
        }
    }
    private func setUpUI() {
        self.contentView.backgroundColor = .black
        dayLabel.textAlignment = .left
        dayOfWeekLabel.textAlignment = .left
        weatherIcon.contentMode = .scaleAspectFit
        windIcon.contentMode = .scaleAspectFit
        windIcon.image = UIImage(systemName: "wind")
        pressureIcon.contentMode = .scaleAspectFit
        pressureIcon.image = UIImage(systemName: "barometer")
        humidityIcon.contentMode = .scaleAspectFit
        humidityIcon.image = UIImage(systemName: "drop")
        for subview in [dayOfWeekLabel, dayLabel, weatherIcon, minTempLabel, maxTempLabel, windIcon, windLabel, humidityIcon, humidityLabel, pressureIcon, pressureLabel] {
            contentView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

extension DailyCell {
    private func configureConstraints() {
        enum Constants {
            static let verticalOffset = 12.0
        }
        NSLayoutConstraint.deactivate(contentView.constraints)
        NSLayoutConstraint.activate([
            dayOfWeekLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dayOfWeekLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayOfWeekLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalOffset),
            dayOfWeekLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalOffset),
            
            weatherIcon.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor),
            weatherIcon.topAnchor.constraint(equalTo: dayOfWeekLabel.topAnchor),
            weatherIcon.bottomAnchor.constraint(equalTo: dayLabel.bottomAnchor),
            weatherIcon.widthAnchor.constraint(equalTo: weatherIcon.heightAnchor, multiplier: 1.0),
            
            minTempLabel.leadingAnchor.constraint(equalTo: weatherIcon.trailingAnchor),
            minTempLabel.topAnchor.constraint(equalTo: dayOfWeekLabel.topAnchor),
            minTempLabel.bottomAnchor.constraint(equalTo: dayLabel.bottomAnchor),
            
            maxTempLabel.widthAnchor.constraint(equalTo: minTempLabel.widthAnchor, multiplier: 1.0),
            maxTempLabel.leadingAnchor.constraint(equalTo: minTempLabel.trailingAnchor),
            maxTempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            maxTempLabel.topAnchor.constraint(equalTo: dayOfWeekLabel.topAnchor),
            maxTempLabel.bottomAnchor.constraint(equalTo: dayLabel.bottomAnchor),
        ])
    }
    private func configureSelectedConstraints() {
        enum Constants {
            static let verticalOffset = 12.0
        }
        NSLayoutConstraint.deactivate(contentView.constraints)
        NSLayoutConstraint.activate([
            dayOfWeekLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dayOfWeekLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayOfWeekLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalOffset),
            
            dayLabel.heightAnchor.constraint(equalTo: dayOfWeekLabel.heightAnchor, multiplier: 1.0),
            dayLabel.topAnchor.constraint(equalTo: dayOfWeekLabel.bottomAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            weatherIcon.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor),
            weatherIcon.topAnchor.constraint(equalTo: dayOfWeekLabel.topAnchor),
            weatherIcon.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherIcon.widthAnchor.constraint(equalTo: weatherIcon.heightAnchor, multiplier: 1.0),
            
            minTempLabel.leadingAnchor.constraint(equalTo: weatherIcon.trailingAnchor),
            minTempLabel.topAnchor.constraint(equalTo: dayOfWeekLabel.topAnchor),
            minTempLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            maxTempLabel.widthAnchor.constraint(equalTo: minTempLabel.widthAnchor, multiplier: 1.0),
            maxTempLabel.leadingAnchor.constraint(equalTo: minTempLabel.trailingAnchor),
            maxTempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            maxTempLabel.topAnchor.constraint(equalTo: dayOfWeekLabel.topAnchor),
            maxTempLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            windIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            windIcon.heightAnchor.constraint(equalTo: windIcon.widthAnchor, multiplier: 3.0),
            windIcon.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            windIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalOffset),
            
            windLabel.leadingAnchor.constraint(equalTo: windIcon.trailingAnchor),
            windLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            windLabel.bottomAnchor.constraint(equalTo: windIcon.bottomAnchor),
            
            humidityIcon.heightAnchor.constraint(equalTo: humidityIcon.widthAnchor, multiplier: 3.0),
            humidityIcon.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            humidityIcon.bottomAnchor.constraint(equalTo: windIcon.bottomAnchor),
            
            humidityLabel.centerXAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor),
            humidityLabel.leadingAnchor.constraint(equalTo: humidityIcon.trailingAnchor),
            humidityLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            humidityLabel.bottomAnchor.constraint(equalTo: windIcon.bottomAnchor),
            
            pressureIcon.trailingAnchor.constraint(equalTo: pressureLabel.leadingAnchor),
            pressureIcon.heightAnchor.constraint(equalTo: pressureIcon.widthAnchor, multiplier: 3.0),
            pressureIcon.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            pressureIcon.bottomAnchor.constraint(equalTo: windIcon.bottomAnchor),
            
            pressureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pressureLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            pressureLabel.bottomAnchor.constraint(equalTo: windIcon.bottomAnchor)
        ])
    }
}
