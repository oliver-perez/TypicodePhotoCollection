//
//  TypicodePhotoCollectionTests.swift
//  TypicodePhotoCollectionTests
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import XCTest
import RxSwift
import RxTest
@testable import TypicodePhotoCollection

final class AlbumColletionRemoteApiClientTests: XCTestCase {

    private var disposeBag: DisposeBag!
    var sut: AlbumColletionRemoteApiClient!
    var urlSessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        urlSessionMock = URLSessionMock()
        sut = AlbumColletionRemoteApiClient(urlSession: urlSessionMock)
    }
    
    override func tearDown() {
        disposeBag = nil
        sut = nil
        urlSessionMock = nil
        super.tearDown()
    }

    func test_getPhotoColletion_loadsCorrectURL() throws {
        // Given
        let baseURL = try XCTUnwrap(AlbumColletionRemoteEndpoint.photoCollections.baseURL)
        let path = try XCTUnwrap(AlbumColletionRemoteEndpoint.photoCollections.path)
        let expectedURL = baseURL.appendingPathComponent(path)
        urlSessionMock.testData = try? XCTUnwrap(getData(for: "TypicodePhotosResponse"))
        // When
        sut.get(type: [PhotoDetail].self, from: AlbumColletionRemoteEndpoint.photoCollections)
            .subscribe()
            .disposed(by: disposeBag)
        // Then
        XCTAssertEqual(urlSessionMock.lastURL, expectedURL)
    }
    
    // MARK: - Helper methods
    func getData(for filename: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: filename, withExtension: "json") else { return nil }
        return try? Data(contentsOf: url)
    }

}
