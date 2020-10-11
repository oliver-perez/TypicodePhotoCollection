//
//  RemoteEndpoint.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import Foundation

protocol RemoteEndpoint {
    var baseURL: URL? { get }
    var path: String? { get }
}
