//
//  RemoteApiClient.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import Foundation
import RxSwift

// MARK: - RemoteApiClient
protocol RemoteApiClient {
    // MARK: - Properties
    var urlSession: URLSession { get set }
    
    // MARK: - Initializers
    init(urlSession: URLSession)
    
    // MARK: - Methods
    func executeDataTaskRequest(from url: URL?, completion: @escaping (Result<Data, Error>) -> Void)
    func makeURL(from endpoint: RemoteEndpoint) -> URL?
}

// MARK: RemoteApiClient default implementations extension
extension RemoteApiClient {
    func executeDataTaskRequest(from url: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = url else { return completion(.failure(NetworkError.invalidURL)) }
        urlSession.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(NetworkError.unknown(detail: String(describing: error))))
            }
            guard let data = data else {
                return completion(.failure(NetworkError.parse))
            }
            
            return completion(.success(data))
        }
        .resume()
    }
    
    func makeURL(from endpoint: RemoteEndpoint) -> URL? {
        guard let path = endpoint.path else { return endpoint.baseURL }
        return endpoint.baseURL?.appendingPathComponent(path)
    }
}
