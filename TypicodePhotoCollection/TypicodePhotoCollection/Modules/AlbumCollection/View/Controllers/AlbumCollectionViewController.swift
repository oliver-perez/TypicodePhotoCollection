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
    private typealias PhotoAlbums = [Int: [PhotoDetail]]
    private typealias Localizable = AlbumCollectionLocalizable
    
    // MARK: - Internal properties
    let viewModel: AlbumCollectionViewModelProtocol
    
    // MARK: - Private properties
    private let disposeBag = DisposeBag()
    private lazy var albumsCollectionView: UICollectionView = makeAlbumsCollectionView()
    private let albumsCollectionViewDelegate = AlbumCollectionViewDelegate()
    private let albumsCollectionDataSource = AlbumCollectionViewDataSource()
    
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
        title = Localizable.albumViewControllerTitle.localized
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
        albumsCollectionDataSource.setPhotoAlbums(photoAlbums: photoAlbums)
        albumsCollectionView.reloadData()
    }
    
    private func handleErrorState(with description: String) {
        // TODO: Show error alert
    }

}

// MARK: - AlbumCollectionViewController view factory methods extension
extension AlbumCollectionViewController {
    private func makeAlbumsCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.delegate = albumsCollectionViewDelegate
        collectionView.dataSource = albumsCollectionDataSource
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AlbumCollectionViewCell.self))
        albumsCollectionViewDelegate
            .itemSelectedItem
            .subscribe(onNext: { [weak self] itemIndex in
                self?.viewModel.didSelectAlbum(at: itemIndex)
            })
            .disposed(by: disposeBag)
        return collectionView
    }
}

// MARK: - Autolayour setup extension
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
