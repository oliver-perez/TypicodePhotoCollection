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
    private let photoSelectedSubject = PublishSubject<(index: Int, album: [PhotoDetail])>()
    private var album: [PhotoDetail] = []
    
    // MARK: - Internal variables
    var albumDriver: Driver<[URL]> {
        albumRelay.asDriver()
    }
    
    var photoSelected: Observable<(index: Int, album: [PhotoDetail])> {
        photoSelectedSubject.asObservable()
    }
    
    // MARK: - Initializers
    init(album: [PhotoDetail]) {
        albumRelay.accept(album.map { $0.thumbnailUrl })
        self.album = album
    }
    
    func didSelectPhoto(at index: Int) {
        photoSelectedSubject.onNext((index, album))
    }

}
