//
//  AlbumCollectionViewDataSource.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import UIKit

final class AlbumCollectionViewDataSource: NSObject {
    
    // MARK: - Typealias
    typealias PhotoAlbums = [Int: [PhotoDetail]]
    private typealias Localizable = AlbumCollectionLocalizable

    // MARK: - Private properties
    private var photoAlbums: PhotoAlbums = [:]
    private lazy var albumIds: [Int] = {
        photoAlbums.keys.sorted()
    }()
    
    // MARK: - Internal Methods
    func setPhotoAlbums(photoAlbums: PhotoAlbums) {
        self.photoAlbums = photoAlbums
    }

}

// MARK: - UICollectionViewDataSource extension
extension AlbumCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoAlbums.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AlbumCollectionViewCell.self), for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell() }
        let photoAlbum = photoAlbums[albumIds[indexPath.item]]
        let photoDetail = photoAlbum?.first
        if let thumbnailUrl = photoDetail?.thumbnailUrl {
            cell.setImage(from: thumbnailUrl)
        }
        cell.set(title: Localizable.albumTitle.formatted(argument: "\(photoDetail?.albumId ?? .zero)"),
                 description: Localizable.albumDescription.formatted(argument: "\(photoAlbum?.count ?? .zero)"))
        return cell
    }
}
