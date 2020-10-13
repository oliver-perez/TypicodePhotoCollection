//
//  PhotoDetailViewDataSource.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 13/10/20.
//

import UIKit

final class PhotoDetailViewDataSource: NSObject {
    
    // MARK: - Private properties
    var albumURLs: [URL] = []
    
    // MARK: - Internal Methods
    func set(albumURLs: [URL]) {
        self.albumURLs = albumURLs
    }
    
}

// MARK: - UICollectionViewDataSource extension
extension PhotoDetailViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albumURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCell.self), for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.setImage(from: albumURLs[indexPath.item])
        return cell
    }
}
