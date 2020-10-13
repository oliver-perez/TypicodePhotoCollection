//
//  PhotoCollectionsState.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import Foundation

enum PhotoCollectionsState {
    case loading
    case ready([Int: [PhotoDetail]])
    case error(String)
}
