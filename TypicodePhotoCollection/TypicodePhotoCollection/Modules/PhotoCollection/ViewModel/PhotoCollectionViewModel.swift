//
//  PhotoCollectionViewModel.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 12/10/20.
//

import Foundation
import RxSwift
import RxCocoa

final class PhotoCollectionViewModel: PhotoCollectionViewModelProtocol {
    
    // MARK: - Private Properties
    private let albumRelay = BehaviorRelay<[URL]>(value: [])
    
    // MARK: - Internal variables
    var albumDriver: Driver<[URL]> {
        albumRelay.asDriver()
    }
    
    // MARK: - Initializers
    init(album: [PhotoDetail]) {
        albumRelay.accept(album.map { $0.thumbnailUrl })
    }

}
