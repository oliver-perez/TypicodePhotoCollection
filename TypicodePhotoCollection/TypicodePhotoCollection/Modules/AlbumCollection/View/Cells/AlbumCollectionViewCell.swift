//
//  AlbumCollectionViewCell.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import UIKit

final class AlbumCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // MARK: - Private methods
    private func setupUI() {
        backgroundColor = .blue
    }
}
