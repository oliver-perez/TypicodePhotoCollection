//
//  Constants.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 12/10/20.
//

import UIKit

enum AlbumCollectionConstants {
    
    struct CollectionViewMetrics {
        static let numberOfItemsPerRow: Int = 2
        static let interItemSpacing: CGFloat = 8.0
        static let cellHeighFactor: CGFloat = 1.3
        static let insets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: interItemSpacing / 2, right: 16.0)
    }
    
    struct CellViewMetrics {
        static let cornerRadiusImage: CGFloat = 8.0
        static let imageLoadingTransitionDuration: Double = 0.5
        static let descriptionLabelFontSize: CGFloat = 14.0
    }
}
