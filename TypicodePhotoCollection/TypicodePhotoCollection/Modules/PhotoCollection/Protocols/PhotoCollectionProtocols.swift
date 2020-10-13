//
//  PhotoCollectionProtocols.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 12/10/20.
//

import Foundation
import RxCocoa

protocol PhotoCollectionViewModelProtocol {
    var albumDriver: Driver<[URL]> { get }
}
