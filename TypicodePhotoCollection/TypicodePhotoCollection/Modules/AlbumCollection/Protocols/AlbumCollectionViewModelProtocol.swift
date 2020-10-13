//
//  AlbumCollectionProtocols.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import Foundation
import RxCocoa

protocol AlbumCollectionViewModelProtocol {
    var photoCollectionsStateDriver: Driver<PhotoCollectionsState> { get }
    /// Method to report viewDidLoad life cycle event from the view controller
    func viewDidLoad()
    func viewLoadWithError()
    func didSelectAlbum(at: Int)
}
