//
//  AlbumCollectionViewModel.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import Foundation
import RxSwift

final class AlbumCollectionViewModel: AlbumCollectionViewModelProtocol {
    
    // MARK: - Typealias
    private typealias Endpoint = AlbumColletionRemoteEndpoint
    
    // MARK: - Private Properties
    private let remoteApiClient: AlbumColletionRemoteApiClientProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    init(remoteApiClient: AlbumColletionRemoteApiClientProtocol) {
        self.remoteApiClient = remoteApiClient
    }
    
    // MARK: - Internal methods
    func viewDidLoad() {
        getPhotoColletion()
    }
    
    private func getPhotoColletion() {
        remoteApiClient
            .get(type: [PhotoDetail].self, from: Endpoint.photoCollections)
            .subscribe { photoDetails in
                print("PhotoDetail object count: \(photoDetails.count)")
            } onError: { error in
                print("\(String(describing: error))")
            }
            .disposed(by: disposeBag)
    }

}
