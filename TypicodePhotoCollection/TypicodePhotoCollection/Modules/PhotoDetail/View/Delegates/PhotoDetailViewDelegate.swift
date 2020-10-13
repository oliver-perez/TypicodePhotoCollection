//
//  PhotoDetailViewDelegate.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 13/10/20.
//

import UIKit
import RxSwift

final class PhotoDetailViewDelegate: NSObject {
    // MARK: Typealias
    private typealias constants = PhotoDetailConstants.CollectionViewMetrics
    
    // MARK: - Private properties
    private let numberOfItemsPerRow: Int
    private let interItemSpacing: CGFloat
    private let itemDidEndDeceleratingSubject = PublishSubject<Void>()
    
    // MARK: - Internal properties
    var itemDidEndDecelerating: Observable<Void> {
        itemDidEndDeceleratingSubject.asObservable()
    }
    
    // MARK: - Initializers
    override init() {
        self.numberOfItemsPerRow = constants.numberOfItemsPerRow
        self.interItemSpacing = constants.interItemSpacing
        super.init()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout extension
extension PhotoDetailViewDelegate: UICollectionViewDelegateFlowLayout {
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        itemDidEndDeceleratingSubject.onNext(())
    }
}

