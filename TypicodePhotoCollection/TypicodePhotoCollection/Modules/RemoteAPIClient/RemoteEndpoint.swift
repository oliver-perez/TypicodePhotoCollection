//
//  RemoteEndpoint.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import Foundation

// MARK: - RemoteEndpoint
protocol RemoteEndpoint {
    var baseURL: URL? { get }
    var path: String? { get }
    
    func getBaseUrl() -> String?
}

// MARK: - RemoteEndpoint default implementations extension
extension RemoteEndpoint {
    func getBaseUrl() -> String? {
        try? AppConfiguration.value(for: "API_BASE_URL")
    }
}
