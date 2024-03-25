//
//  CurrentWeatherView.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

import UIKit

final class CurrentWeatherView: UIView {
    private let temperatureLabel = UILabel.createLabel(font: .boldSystemFont(ofSize: TextSize.veryLarge))
    private let feelsLikeLabel = UILabel.createLabel()
    private let discriptionLabel = UILabel.createLabel()
    private let windSpeedLabel = UILabel.createLabel()
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureView(_ model: CurrentWeatherModel) {
        temperatureLabel.text = "\(Int(model.temp.rounded()))°"
        discriptionLabel.text = model.weather.first?.description
        feelsLikeLabel.text = "Ощущается как: \(Int(model.feels_like.rounded()))°"
        windSpeedLabel.text = "Скорость ветра: \(Int(model.wind_speed)) м/с"
    }
}

extension CurrentWeatherView {
    private enum Constants {
        static let verticalOffset = 4.0
    }
    private func configureConstraints() {
        for subview in [temperatureLabel, discriptionLabel, feelsLikeLabel, windSpeedLabel] {
            addSubview(subview)
        }
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor),
            temperatureLabel.leftAnchor.constraint(equalTo: leftAnchor),
            temperatureLabel.rightAnchor.constraint(equalTo: rightAnchor),
            discriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: Constants.verticalOffset),
            discriptionLabel.leftAnchor.constraint(equalTo: leftAnchor),
            discriptionLabel.rightAnchor.constraint(equalTo: rightAnchor),
            feelsLikeLabel.topAnchor.constraint(equalTo: discriptionLabel.bottomAnchor, constant: Constants.verticalOffset),
            feelsLikeLabel.leftAnchor.constraint(equalTo: leftAnchor),
            feelsLikeLabel.rightAnchor.constraint(equalTo: rightAnchor),
            windSpeedLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: Constants.verticalOffset),
            windSpeedLabel.leftAnchor.constraint(equalTo: leftAnchor),
            windSpeedLabel.rightAnchor.constraint(equalTo: rightAnchor),
            windSpeedLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalOffset)
        ])
    }
}
