//
//  AlbumCollectionViewModel.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import Foundation
import RxSwift
import RxCocoa

final class AlbumCollectionViewModel: AlbumCollectionViewModelProtocol {

    // MARK: - Typealias
    private typealias Endpoint = AlbumColletionRemoteEndpoint
    private typealias PhotoAlbums = [Int: [PhotoDetail]]
    
    // MARK: - Private Properties
    private let remoteApiClient: AlbumColletionRemoteApiClientProtocol
    private let disposeBag = DisposeBag()
    private let photoCollectionsState = BehaviorRelay<PhotoCollectionsState>(value: .loading)
    private let albumSelectedSubject = PublishSubject<[PhotoDetail]>()
    private var photoAlbums: PhotoAlbums = [:]
    
    // MARK: - Internal variables
    var photoCollectionsStateDriver: Driver<PhotoCollectionsState> {
        photoCollectionsState.asDriver()
    }
    
    var albumSelected: Observable<[PhotoDetail]> {
        albumSelectedSubject.asObservable()
    }
    
    // MARK: - Initializers
    init(remoteApiClient: AlbumColletionRemoteApiClientProtocol) {
        self.remoteApiClient = remoteApiClient
    }
    
    // MARK: - Internal methods
    func viewDidLoad() {
        getPhotoColletion()
    }
    
    func viewLoadWithError() {
        getPhotoColletion()
    }
    
    func didSelectAlbum(at index: Int) {
        guard photoAlbums.keys.count > index else { return }
        let albumId = photoAlbums.keys.sorted()[index]
        guard let selectedAlbum = photoAlbums[albumId] else { return }
        albumSelectedSubject.onNext(selectedAlbum)
    }
    
    // MARK: - Private methods
    private func getPhotoColletion() {
        photoCollectionsState.accept(.loading)
        remoteApiClient
            .get(type: [PhotoDetail].self, from: Endpoint.photoCollections)
            .map (groupPhotosByAlbumId)
            .subscribe { [weak self] photoAlbums in
                self?.photoAlbums = photoAlbums
                self?.photoCollectionsState.accept(.ready(photoAlbums))
            } onError: { [weak self] error in
                self?.photoCollectionsState.accept(.error(error.localizedDescription))
            }
            .disposed(by: disposeBag)
    }

    private func groupPhotosByAlbumId(photoDetails: [PhotoDetail]) -> PhotoAlbums {
        photoDetails.reduce(into: [:]) { result, next in
            guard result[next.albumId] != nil else { return result[next.albumId] = [next] }
            result[next.albumId]? += [next]
        }
    }
}
