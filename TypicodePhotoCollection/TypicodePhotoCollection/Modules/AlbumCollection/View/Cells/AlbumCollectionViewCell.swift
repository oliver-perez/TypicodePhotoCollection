//
//  AlbumCollectionViewCell.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import UIKit

final class AlbumCollectionViewCell: UICollectionViewCell {

    lazy var imageView: UIImageView = makeImageView()
    lazy var titleLabel: UILabel = makeTitleLabel()
    lazy var descriptionLabel: UILabel = makeDescriptionLabel()
    lazy var contentStackView: UIStackView = makeStackView()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func layoutSubviews() {
        superview?.layoutSubviews()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8.0
    }
    
    // MARK: - Internal methods
    func set(image: UIImage) {
        imageView.image = image
    }
    
    func set(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
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
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func makeTitleLabel() -> UILabel {
        let textLabel = UILabel()
        textLabel.textAlignment = .center
        textLabel.numberOfLines = .zero
        textLabel.textAlignment = .left
        textLabel.setContentHuggingPriority(.required, for: .vertical)
        return textLabel
    }
    
    private func makeDescriptionLabel() -> UILabel {
        let textLabel = UILabel()
        textLabel.textAlignment = .center
        textLabel.numberOfLines = .zero
        textLabel.textAlignment = .left
        return textLabel
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = .zero
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        return stackView
    }
}
