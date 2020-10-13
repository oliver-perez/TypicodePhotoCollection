//
//  MainCoordinator.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import UIKit
import RxSwift

final class MainCoordinator {

    // MARK: Internal properties
    var navigationController = UINavigationController()

    // MARK: - Private properties
    private var window = UIWindow(frame: UIScreen.main.bounds)
    private let disposeBag = DisposeBag()

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
        let viewModel = AlbumCollectionViewModel(remoteApiClient: AlbumColletionRemoteApiClient())
        let viewController = AlbumCollectionViewController(viewModel: viewModel)
        
        viewModel.albumSelected
            .subscribe(onNext: { [weak self] album in
                self?.showPhotoCollection(for: album)
            })
            .disposed(by: disposeBag)
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showPhotoCollection(for album: [PhotoDetail]) {
        let viewController = PhotoCollectionViewController()
        navigationController.pushViewController(viewController, animated: true)
    }

}
