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
    
    // MARK: - Private Properties
    private let remoteApiClient: AlbumColletionRemoteApiClientProtocol
    private let disposeBag = DisposeBag()
    let photoCollectionsState = BehaviorRelay<PhotoCollectionsState>(value: .loading)
    
    // MARK: - Initializers
    init(remoteApiClient: AlbumColletionRemoteApiClientProtocol) {
        self.remoteApiClient = remoteApiClient
    }
    
    // MARK: - Internal methods
    func viewDidLoad() {
        getPhotoColletion()
    }
    
    private func getPhotoColletion() {
        photoCollectionsState.accept(.loading)
        remoteApiClient
            .get(type: [PhotoDetail].self, from: Endpoint.photoCollections)
            .map (groupPhotosByAlbumId)
            .subscribe { [weak self] photoCollections in
                self?.photoCollectionsState.accept(.ready(photoCollections))
            } onError: { [weak self] error in
                self?.photoCollectionsState.accept(.error(error.localizedDescription))
            }
            .disposed(by: disposeBag)
    }

    private func groupPhotosByAlbumId(photoDetails: [PhotoDetail]) -> [Int: [PhotoDetail]] {
        photoDetails.reduce(into: [:]) { result, next in
            guard result[next.albumId] != nil else { return result[next.albumId] = [next] }
            result[next.albumId]? += [next]
        }
    }
}

// MARK: - AlbumCollectionViewModel PhotoCollectionState extension
extension AlbumCollectionViewModel {
    enum PhotoCollectionsState {
        case loading
        case ready([Int: [PhotoDetail]])
        case error(String)
    }
}
