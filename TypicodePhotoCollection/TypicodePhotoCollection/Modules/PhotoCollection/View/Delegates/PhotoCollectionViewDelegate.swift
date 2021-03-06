//
//  PhotoCollectionViewDelegate.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 12/10/20.
//

import UIKit
import RxSwift

final class PhotoCollectionViewDelegate: NSObject {
    // MARK: Typealias
    private typealias constants = PhotoCollectionConstants.CollectionViewMetrics
    
    // MARK: - Private properties
    private let numberOfItemsPerRow: Int
    private let interItemSpacing: CGFloat
    private let itemSelectedSubject = PublishSubject<Int>()
    
    // MARK: - Internal properties
    var itemSelectedItem: Observable<Int> {
        itemSelectedSubject.asObservable()
    }
    
    // MARK: - Initializers
    override init() {
        self.numberOfItemsPerRow = constants.numberOfItemsPerRow
        self.interItemSpacing = constants.interItemSpacing
        super.init()
    }
}

// MARK: - UICollectionViewDelegate extension
extension PhotoCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSelectedSubject.onNext(indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout extension
extension PhotoCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth = UIScreen.main.bounds.width - (constants.insets.left + constants.insets.right)
        let totalSpacing = interItemSpacing * CGFloat(numberOfItemsPerRow)
        let itemWidth = (maxWidth - totalSpacing) / CGFloat(numberOfItemsPerRow)
        return CGSize(width: itemWidth, height: itemWidth * constants.cellHeighFactor)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        interItemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        constants.insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        interItemSpacing
    }
}

