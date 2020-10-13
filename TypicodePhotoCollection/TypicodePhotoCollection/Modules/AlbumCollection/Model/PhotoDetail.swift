//
//  PhotoDetail.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import Foundation

struct PhotoDetail: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}
