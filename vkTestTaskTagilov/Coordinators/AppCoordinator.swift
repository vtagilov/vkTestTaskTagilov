//
//  AppCoordinator.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 19.03.2024.
//

import UIKit

protocol Coordinator {
    var paretCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}


final class AppCoordinator {
    var parentCoordinator: Coordinator? = nil
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        goToMainPage()
    }
    func goToMainPage(){
        let viewController = MainViewController()
        let viewModel = MainViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    func goToSearchPage(){
        let viewController = SearchViewController()
        let viewModel = SearchViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    func goBackToMainPage(_ locationName: String? = nil) {
        navigationController.popViewController(animated: true)
        guard let locationName = locationName else {
            return
        }
        guard let mainVC = navigationController.viewControllers.first as? MainViewController else {
            return
        }
        mainVC.loadingView.isHidden = false
        mainVC.viewModel.getWeather(locationName)
    }
}
