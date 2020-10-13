//
//  PhotoDetailViewModel.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 13/10/20.
//

import Foundation
import RxSwift
import RxCocoa

final class PhotoDetailViewModel: PhotoDetailViewModelProtocol {
    
    // MARK: - Private Properties
    private let albumRelay = BehaviorRelay<(selectedIndex: Int, album: [PhotoDetail])>(value: (selectedIndex: Int(), album: []))
    
    // MARK: - Internal variables
    var albumDriver: Driver<(selectedIndex: Int, album: [PhotoDetail])> {
        albumRelay.asDriver()
    }
    
    // MARK: - Initializers
    init(selectedIndex: Int, album: [PhotoDetail]) {
        albumRelay.accept((selectedIndex: selectedIndex, album))
    }

}
