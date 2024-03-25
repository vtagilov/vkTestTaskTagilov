//
//  LoadingView.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 21.03.2024.
//

import UIKit

final class LoadingView: UIView {
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    private let grayView = UIView()
    private let backgroundView = UIView()
    init() {
        super.init(frame: .zero)
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.5
        activityIndicator.startAnimating()
        grayView.backgroundColor = .darkGray
        grayView.layer.cornerRadius = 16
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingView {
    private func configureConstraints() {
        enum Constants {
            static let grayViewSize = 100.0
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        for subview in [grayView, activityIndicator, backgroundView] {
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            grayView.centerYAnchor.constraint(equalTo: centerYAnchor),
            grayView.centerXAnchor.constraint(equalTo: centerXAnchor),
            grayView.widthAnchor.constraint(equalToConstant: Constants.grayViewSize),
            grayView.heightAnchor.constraint(equalToConstant: Constants.grayViewSize),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
