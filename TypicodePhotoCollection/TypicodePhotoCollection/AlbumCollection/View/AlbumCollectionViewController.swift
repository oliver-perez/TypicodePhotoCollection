//
//  AlbumCollectionViewController.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import UIKit

final class AlbumCollectionViewController: UIViewController {
    
    // MARK: Internal properties
    let viewModel: AlbumCollectionViewModelProtocol
    
    // MARK: - Initializers
    init(viewModel: AlbumCollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        // TODO: Delete this line, it's just to ensure this vc is being shown in the window.
        view.backgroundColor = .blue
    }

}
