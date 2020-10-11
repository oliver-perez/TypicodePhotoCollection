//
//  AlbumCollectionViewController.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import UIKit
import RxSwift

final class AlbumCollectionViewController: UIViewController {
    
    // MARK: - Typealias
    typealias PhotoAlbums = [Int: [PhotoDetail]]
    
    // MARK: - Internal properties
    let viewModel: AlbumCollectionViewModelProtocol
    
    // MARK: - Private properties
    private let disposeBag = DisposeBag()
    private var photoAlbums: PhotoAlbums = [:]
    
    // MARK: - Initializers
    init(viewModel: AlbumCollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindToViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        // TODO: Delete this line, it's just to ensure this vc is being shown in the window.
        view.backgroundColor = .blue
    }
    
    // MARK: Private methods
    private func bindToViewModel() {
        viewModel
            .photoCollectionsStateDriver
            .drive(onNext: { [weak self] state in
                self?.handle(state: state)
            })
            .disposed(by: disposeBag)
    }
    
    private func handle(state: PhotoCollectionsState) {
        switch state {
        case .loading:
            handleLoadingState()
        case .ready(let photoAlbums):
            handleReadyState(with: photoAlbums)
        case .error(let description):
            handleErrorState(with: description)
        }
    }
    
    private func handleLoadingState() {
        // TODO: Show loading animation
    }
    
    private func handleReadyState(with photoAlbums: PhotoAlbums) {
        self.photoAlbums = photoAlbums
    }
    
    private func handleErrorState(with description: String) {
        // TODO: Show error alert
    }

}
