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
    private lazy var albumsCollectionView: AlbumCollectionView = makeAlbumsCollectionView()
    
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
        setupUI()
    }
    
    // MARK: Private methods
    
    private func setupUI() {
        setupAlbumCollectionViewConstraints()
    }
    
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
        albumsCollectionView.reloadData()
    }
    
    private func handleErrorState(with description: String) {
        // TODO: Show error alert
    }

}

// MARK: - AlbumCollectionViewController view factory methods extension
extension AlbumCollectionViewController {
    private func makeAlbumsCollectionView() -> AlbumCollectionView {
        let layout = UICollectionViewFlowLayout()
        let collectionView = AlbumCollectionView(layout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AlbumCollectionViewCell.self))
        return collectionView
    }
}

extension AlbumCollectionViewController {
    private func setupAlbumCollectionViewConstraints() {
        albumsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(albumsCollectionView)
        NSLayoutConstraint.activate([
            albumsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            albumsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            albumsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            albumsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UICollectionView delegates extension
extension AlbumCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoAlbums.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AlbumCollectionViewCell.self), for: indexPath)
        return cell
    }
}
