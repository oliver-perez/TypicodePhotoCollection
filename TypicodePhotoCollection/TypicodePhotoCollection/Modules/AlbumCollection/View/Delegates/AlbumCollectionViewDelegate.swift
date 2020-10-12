//
//  AlbumCollectionViewDelegate.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import UIKit
import RxCocoa
import RxSwift

final class AlbumCollectionViewDelegate: NSObject {
    
    // MARK: - Private properties
    private let numberOfItemsPerRow: CGFloat
    private let interItemSpacing: CGFloat
    private let itemSelectedSubject = PublishSubject<Int>()
    
    // MARK: - Internal properties
    var itemSelectedItem: Observable<Int> {
        itemSelectedSubject.asObservable()
    }
    
    // MARK: - Initializers
    init(numberOfItemsPerRow: CGFloat = 2.0, interItemSpacing: CGFloat = 8.0) {
        self.numberOfItemsPerRow = numberOfItemsPerRow
        self.interItemSpacing = interItemSpacing
    }
}

// MARK: - UICollectionViewDelegate extension
extension AlbumCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSelectedSubject.onNext(indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout extension
extension AlbumCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth = UIScreen.main.bounds.width - 32.0
        let totalSpacing = interItemSpacing * numberOfItemsPerRow
        let itemWidth = (maxWidth - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: itemWidth, height: itemWidth * 1.25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        interItemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20.0, left: 16.0, bottom: interItemSpacing / 2, right: 16.0)
    }
}
