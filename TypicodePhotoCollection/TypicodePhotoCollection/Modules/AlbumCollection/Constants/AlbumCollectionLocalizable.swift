//
//  Localizable.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 12/10/20.
//

import Foundation

enum AlbumCollectionLocalizable: String {
    case albumViewControllerTitle = "album_view_controller_title"
    case albumTitle = "album_cell_title"
    case albumDescription = "album_cell_description"
    
    var localized: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
    
    func formatted(argument: String) -> String {
        String(format: localized, argument)
    }
}
