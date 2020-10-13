//
//  PhotoViewController.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 12/10/20.
//

import UIKit
import RxSwift

final class PhotoCollectionViewController: UIViewController {

    // MARK: - Typealias
    private typealias Localizable = AlbumCollectionLocalizable
    
    // MARK: - Private properties
    private lazy var photoCollectionView: UICollectionView = makePhotoCollectionView()
    let photoCollectionViewDelegate = PhotoCollectionViewDelegate()
    let photoCollectionDataSource = PhotoCollectionViewDataSource()
    private let disposeBag = DisposeBag()
    
    // MARK: - Internal properties
    let viewModel: PhotoCollectionViewModel
    
    // MARK: - Initializers
    init(viewModel: PhotoCollectionViewModel, albumId: String) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = Localizable.albumTitle.formatted(argument: albumId)
        bindToViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        photoCollectionView.reloadData()
    }
    
    // MARK: Private methods
    private func setupUI() {
        setupCollectionViewConstraints()
    }
    
    private func bindToViewModel() {
        viewModel
            .albumDriver
            .drive(onNext: { [weak self] albumURLs in
                self?.photoCollectionDataSource.set(albumURLs: albumURLs)
                self?.photoCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }

}

// MARK: - PhotoCollectionViewController view factory methods extension
extension PhotoCollectionViewController {
    private func makePhotoCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.delegate = photoCollectionViewDelegate
        collectionView.dataSource = photoCollectionDataSource
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: String(describing: PhotoCell.self))
        photoCollectionViewDelegate
            .itemSelectedItem
            .subscribe(onNext: { [weak self] itemIndex in
                self?.viewModel.didSelectPhoto(at: itemIndex)
            })
            .disposed(by: disposeBag)
        return collectionView
    }
}

// MARK: - Autolayout setup extension
extension PhotoCollectionViewController {
    private func setupCollectionViewConstraints() {
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoCollectionView)
        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
