//
//  MainViewController.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 19.03.2024.
//

import UIKit

final class MainViewController: UIViewController {
    var viewModel: MainViewModel!
    let loadingView = LoadingView()
    
    private let currentWeatherView = CurrentWeatherView()
    internal var errorView = ErrorView()
    private let dailyLabel = UILabel.createLabel(text: "Прогноз на неделю:", font: .systemFont(ofSize: TextSize.medium))
    private var favoriteBarButton: UIBarButtonItem!
    private let dailyTableView = DailyTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateUICompletion = { model in
            DispatchQueue.main.async {
                self.configureView(model)
            }
        }
        viewModel.errorCompletion = { error in
            DispatchQueue.main.async {
                self.errorView.isHidden = false
                self.loadingView.isHidden = true
                self.errorView.configure(error)
            }
        }
        viewModel.getWeather()
        setUpUI()
        configureConstraints()
    }
    
    private func configureView(_ model: WeatherResponseModel) {
        currentWeatherView.configureView(model.current)
        dailyTableView.setData(model.daily)
        if let cityName = model.cityName {
            self.title = cityName
        }
        setFavoriteButtonImage()
        loadingView.isHidden = true
    }
    
    private func setUpUI() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let searchBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonAction))
        self.navigationItem.rightBarButtonItem = searchBarButton
        favoriteBarButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favoriteButtonAction))
        favoriteBarButton.changesSelectionAsPrimaryAction = false
        self.navigationItem.leftBarButtonItem = favoriteBarButton
        dailyLabel.textAlignment = .left
        errorView.delegate = self
        errorView.isHidden = true
    }
    
    private func setFavoriteButtonImage() {
        if let city = self.title {
            if city == "" {
                return
            }
            switch viewModel.isFavorite(city) {
            case false:
                favoriteBarButton.image = UIImage(systemName: "star")
            case true:
                favoriteBarButton.image = UIImage(systemName: "star.fill")
            }
        } else {
            favoriteBarButton.image = UIImage(systemName: "star")
        }
    }
    
    @objc private func searchButtonAction() {
        viewModel.goToSearchPage()
    }
    @objc private func favoriteButtonAction() {
        if let city = self.title {
            viewModel.addFavoritePlace(city)
            favoriteBarButton.isSelected = false
            setFavoriteButtonImage()
        }
    }
}

extension MainViewController {
    private func configureConstraints() {
        enum Constants {
            static let verticalSpacing = 8.0
            static let horizontalSpacing = 8.0
            static let buttonSize = 25.0
        }
        for subview in [currentWeatherView, dailyLabel, dailyTableView, loadingView, errorView] {
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            currentWeatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.verticalSpacing),
            currentWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            dailyLabel.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: Constants.verticalSpacing),
            dailyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            dailyTableView.topAnchor.constraint(equalTo: dailyLabel.bottomAnchor, constant: Constants.verticalSpacing),
            dailyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dailyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
