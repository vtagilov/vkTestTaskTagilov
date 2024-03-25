//
//  AppDelegate.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 19.03.2024.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(navController: UINavigationController())
        appCoordinator?.start()
        window?.rootViewController = appCoordinator?.navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

