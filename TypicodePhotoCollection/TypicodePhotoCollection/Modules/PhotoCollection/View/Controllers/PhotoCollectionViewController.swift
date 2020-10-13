//
//  PhotoViewController.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 12/10/20.
//

import UIKit
import RxSwift

final class PhotoCollectionViewController: UIViewController {

    // MARK: - Private properties
    private lazy var photoCollectionView: UICollectionView = makePhotoCollectionView()
    let photoCollectionViewDelegate = PhotoCollectionViewDelegate()
    let photoCollectionDataSource = PhotoCollectionViewDataSource()
    private let disposeBag = DisposeBag()
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        photoCollectionView.reloadData()
    }
    
    // MARK: Private methods
    private func setupUI() {
        title = "Album 1"
        setupCollectionViewConstraints()
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
//                self?.viewModel.didSelectAlbum(at: itemIndex)
            })
            .disposed(by: disposeBag)
        return collectionView
    }
}

// MARK: - Autolayour setup extension
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
