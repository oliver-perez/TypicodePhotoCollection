//
//  AlbumCollectionViewCell.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import UIKit

final class AlbumCollectionViewCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dummyImage")
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text  = "Album"
        textLabel.textAlignment = .center
        textLabel.numberOfLines = .zero
        textLabel.textAlignment = .left
        textLabel.setContentHuggingPriority(.required, for: .vertical)
        return textLabel
    }()
    
    lazy var descriptionLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text  = "100"
        textLabel.textAlignment = .center
        textLabel.numberOfLines = .zero
        textLabel.textAlignment = .left
        return textLabel
    }()

    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = .zero
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        return stackView
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8.0
    }
   
    // MARK: - Private methods
    private func setupUI() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentStackView)

        let imageWidthContraint = imageView.widthAnchor.constraint(equalTo: widthAnchor)


        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            imageWidthContraint
        ])
        imageWidthContraint.priority = .defaultHigh
    }
}
