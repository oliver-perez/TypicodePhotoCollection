//
//  PhotoCell.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 12/10/20.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    
    // MARK: Typealias
    private typealias constants = PhotoCollectionConstants.CellViewMetrics

    // MARK: - Private properties
    private lazy var imageView: UIImageView = makeImageView()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal methods
    func setImage(from url: URL) {
        imageView.kf.setImage(
            with: url,
            options: [
                .transition(.fade(constants.imageLoadingTransitionDuration))
            ])
    }
    
    // MARK: - Private methods
    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        return imageView
    }
}
