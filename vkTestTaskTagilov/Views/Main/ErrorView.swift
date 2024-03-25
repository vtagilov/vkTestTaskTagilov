//
//  ErrorView.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 25.03.2024.
//

import UIKit

protocol ErrorViewDelegate {
    func tryAgainButtonTapped(_ error: NetworkError)
}

extension MainViewController: ErrorViewDelegate {
    func tryAgainButtonTapped(_ error: NetworkError) {
        self.viewModel.updateWeather()
        self.errorView.isHidden = true
        self.loadingView.isHidden = false
    }
}

final class ErrorView: UIView {
    private var errorImageView = UIImageView()
    private let errorLabel = UILabel.createLabel(text: "Произошла ошибка")
    private let errorDescriptionLabel = UILabel.createLabel(font: .systemFont(ofSize: TextSize.small))
    private let tryAgainButton = UIButton()
    private var error: NetworkError!
    var delegate: ErrorViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setUpUI()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(_ error: NetworkError) {
        self.error = error
        errorImageView.image = UIImage(named: error.imageName)
        errorDescriptionLabel.text = error.description
        switch error {
        case .invalidLocation:
            tryAgainButton.setTitle("Закрыть", for: .normal)
        case .noInternetConnectivity:
            tryAgainButton.setTitle("Повторить попытку", for: .normal)
        default:
            tryAgainButton.setTitle("Закрыть", for: .normal)
        }
    }
    private func setUpUI() {
        self.isHidden = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        errorImageView.contentMode = .scaleAspectFit
        tryAgainButton.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
        tryAgainButton.setTitleColor(.systemBlue, for: .normal)
    }
    @objc private func tryAgainButtonTapped() {
        delegate?.tryAgainButtonTapped(error)
    }
}

extension ErrorView {
    enum Constants {
        static let imageSize = 100.0
        static let verticalSpacing = 12.0
    }
    private func configureConstraints() {
        for subview in [errorImageView, errorLabel, errorDescriptionLabel, tryAgainButton] {
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
        NSLayoutConstraint.activate([
            errorImageView.bottomAnchor.constraint(equalTo: errorLabel.topAnchor),
            errorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImageView.heightAnchor.constraint(lessThanOrEqualToConstant: Constants.imageSize),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.leftAnchor.constraint(equalTo: leftAnchor),
            errorLabel.rightAnchor.constraint(equalTo: rightAnchor),
            errorDescriptionLabel.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: Constants.verticalSpacing),
            errorDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor),
            errorDescriptionLabel.rightAnchor.constraint(equalTo: rightAnchor),
            tryAgainButton.topAnchor.constraint(equalTo: errorDescriptionLabel.bottomAnchor, constant: Constants.verticalSpacing),
            tryAgainButton.leftAnchor.constraint(equalTo: leftAnchor),
            tryAgainButton.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
