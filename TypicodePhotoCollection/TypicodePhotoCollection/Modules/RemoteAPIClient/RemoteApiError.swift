//
//  RemoteApiError.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import Foundation

enum NetworkError: Error {
    case parse
    case invalidURL
    case resourceNotFound
    case unknown(detail: String)
}
