//
//  AlbumColletionRemoteEndpoint.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import Foundation

enum AlbumColletionRemoteEndpoint: RemoteEndpoint {
    case photoCollections
    
    var baseURL: URL? {
        guard let baseURL = getBaseUrl() else { return nil }
        return URL(string: baseURL)
    }
    
    var path: String? {
        "/photos"
    }

}
