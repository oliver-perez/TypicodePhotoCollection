//
//  PhotoDetailViewController.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 13/10/20.
//

import UIKit
import RxSwift

final class PhotoDetailViewController: UIViewController {
    
    // MARK: - Typealias
    private typealias Localizable = AlbumCollectionLocalizable
    
    // MARK: - Private properties
    private lazy var photoDetailCollectionView: UICollectionView = makeCollectionView()
    private let disposeBag = DisposeBag()
    private var selectedPhotoIndex: Int = 0

    // MARK: - Internal properties
    let photoDetailViewDelegate = PhotoDetailViewDelegate()
    let photoDetailDataSource = PhotoDetailViewDataSource()
    let viewModel: PhotoDetailViewModel

    // MARK: - Initializers
    init(viewModel: PhotoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
        bindToViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoDetailCollectionView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width * CGFloat(selectedPhotoIndex), y: photoDetailCollectionView.contentOffset.y), animated: false)
    }
    
    // MARK: Private methods
    private func setupUI() {
        setupCollectionViewConstraints()
    }

    private func bindToViewModel() {
        viewModel
            .albumDriver
            .drive(onNext: { [weak self] selectionDetail in
                let selectedIndex = selectionDetail.selectedIndex
                self?.selectedPhotoIndex = selectedIndex
                self?.photoDetailDataSource.set(albumURLs: selectionDetail.album.map { $0.url } )
                self?.photoDetailCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - PhotoDetailViewController view factory methods extension
extension PhotoDetailViewController {
    private func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = photoDetailViewDelegate
        collectionView.dataSource = photoDetailDataSource
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: String(describing: PhotoCell.self))
        collectionView.isPagingEnabled = true
        return collectionView
    }
}

// MARK: - Autolayout setup extension
extension PhotoDetailViewController {
    private func setupCollectionViewConstraints() {
        photoDetailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoDetailCollectionView)
        NSLayoutConstraint.activate([
            photoDetailCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photoDetailCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photoDetailCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoDetailCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
