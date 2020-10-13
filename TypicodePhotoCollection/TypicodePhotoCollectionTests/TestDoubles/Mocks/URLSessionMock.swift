//
//  File.swift
//  TypicodePhotoCollectionTests
//
//  Created by Oliver Jordy Pérez Escamilla on 13/10/20.
//

import Foundation
@testable import TypicodePhotoCollection

final class URLSessionMock: URLSessionProtocol {
    
    var lastURL: URL?
    var testData: Data?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        lastURL = url
        defer { completionHandler(testData, nil, nil) }
        return DataTaskMock()
    }
}
