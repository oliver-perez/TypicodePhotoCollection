//
//  AlbumColletionRemoteApiClient.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import Foundation
import RxSwift

// MARK: - AlbumColletionRemoteApiClient
final class AlbumColletionRemoteApiClient: AlbumColletionRemoteApiClientProtocol {
    
    // MARK: - Private Properties
    var urlSession: URLSessionProtocol
    
    // MARK: - Initializers
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    // MARK: - Interface methods
    func get<T: Decodable>(type: T.Type, from endpoint: RemoteEndpoint) -> Single<T> {
        Single<T>.create { [weak self] single in
            self?.executeDataTaskRequest(from: self?.makeURL(from: endpoint)) { result in
                switch result {
                case .success(let data):
                    if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                        single(.success(responseObject))
                    } else {
                        single(.error(NetworkError.parse))
                    }
                case .failure(let error):
                    single(.error(error))
                }
            }
            return Disposables.create()
        }
    }

}
