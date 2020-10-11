//
//  MainCoordinator.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import UIKit

final class MainCoordinator {

    // MARK: Internal properties
    var navigationController = UINavigationController()

    // MARK: - Private properties
    private var window = UIWindow(frame: UIScreen.main.bounds)

    func start(windowScene: UIWindowScene) {
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
        window.windowScene = windowScene
        showInitialView()
    }

    func showInitialView() {
        let initialViewController = UIViewController()
        initialViewController.view.backgroundColor = .blue
        navigationController.pushViewController(initialViewController, animated: false)
    }

}
