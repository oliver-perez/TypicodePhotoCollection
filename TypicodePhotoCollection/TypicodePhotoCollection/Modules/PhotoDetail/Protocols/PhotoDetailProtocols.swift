//
//  PhotoDetailProtocols.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 13/10/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol PhotoDetailViewModelProtocol {
    var albumDriver: Driver<(selectedIndex: Int, album: [PhotoDetail])> { get }
}
