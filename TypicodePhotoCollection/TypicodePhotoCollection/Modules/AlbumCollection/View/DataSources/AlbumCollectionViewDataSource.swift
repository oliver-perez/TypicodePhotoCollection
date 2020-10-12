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
    private lazy var albumIds: [Int] = {
        photoAlbums.keys.sorted()
    }()
    
    func setPhotoAlbums(photoAlbums: PhotoAlbums) {
        self.photoAlbums = photoAlbums
    }
    
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
        cell.set(title: "Album \(photoDetail?.albumId ?? .zero)",
                 description: "\(photoAlbum?.count ?? .zero) photos")
        return cell
    }

}
