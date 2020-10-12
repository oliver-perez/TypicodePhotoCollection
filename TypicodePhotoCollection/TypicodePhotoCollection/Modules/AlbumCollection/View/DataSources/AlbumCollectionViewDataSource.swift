//
//  AlbumCollectionViewDataSource.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import UIKit

final class AlbumCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Typealias
    typealias PhotoAlbums = [Int: [PhotoDetail]]
    // MARK: - Private properties
    private var photoAlbums: PhotoAlbums = [:]
    
    func setPhotoAlbums(photoAlbums: PhotoAlbums) {
        self.photoAlbums = photoAlbums
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoAlbums.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AlbumCollectionViewCell.self), for: indexPath)
        return cell
    }

}
