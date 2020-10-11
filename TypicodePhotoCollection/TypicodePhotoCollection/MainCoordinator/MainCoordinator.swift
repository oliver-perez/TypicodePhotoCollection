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

    private func showInitialView() {
        showAlbumCollectionViewController()
    }

    func showAlbumCollectionViewController() {
        let viewModel = AlbumCollectionViewModel()
        let viewController = AlbumCollectionViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }

}
