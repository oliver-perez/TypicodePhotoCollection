//
//  AlbumColletionRemoteApiClientProtocol.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import Foundation
import RxSwift

// MARK: AlbumColletionRemoteApiClient protocol
protocol AlbumColletionRemoteApiClientProtocol: RemoteApiClient {
    func get<T: Decodable>(type: T.Type, from endpoint: RemoteEndpoint) -> Single<T>
}
