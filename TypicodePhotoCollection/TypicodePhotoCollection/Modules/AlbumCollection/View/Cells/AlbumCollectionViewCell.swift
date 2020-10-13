//
//  AlbumCollectionViewCell.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import UIKit
import Kingfisher

final class AlbumCollectionViewCell: UICollectionViewCell {
    
    // MARK: Typealias
    private typealias constants = AlbumCollectionConstants.CellViewMetrics

    // MARK: - Private properties
    private lazy var imageView: UIImageView = makeImageView()
    private lazy var titleLabel: UILabel = makeTitleLabel()
    private lazy var descriptionLabel: UILabel = makeDescriptionLabel()
    private lazy var contentStackView: UIStackView = makeStackView()

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
        imageView.layer.cornerRadius = constants.cornerRadiusImage
    }
    
    // MARK: - Internal methods
    func setImage(from url: URL) {
        imageView.kf.setImage(
            with: url,
            options: [
                .transition(.fade(constants.imageLoadingTransitionDuration))
            ])
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
            bottomAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: constants.stackViewBottomSpacing),
            titleLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.aspectRatio(constants.imageViewAspectRatio)
        ])
        imageWidthContraint.priority = .defaultHigh
    }
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    private func makeTitleLabel() -> UILabel {
        let textLabel = UILabel()
        textLabel.numberOfLines = .zero
        textLabel.textAlignment = .left
        textLabel.setContentHuggingPriority(.required, for: .vertical)
        textLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        return textLabel
    }
    
    private func makeDescriptionLabel() -> UILabel {
        let textLabel = UILabel()
        textLabel.numberOfLines = .zero
        textLabel.textAlignment = .left
        textLabel.sizeToFit()
        textLabel.font = textLabel.font.withSize(constants.descriptionLabelFontSize)
        textLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        return textLabel
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = constants.stackViewTitleSpacing
        
        let nestedStackView = UIStackView()
        nestedStackView.axis = .vertical
        nestedStackView.distribution = .fill
        nestedStackView.alignment = .fill
        nestedStackView.addArrangedSubview(titleLabel)
        nestedStackView.addArrangedSubview(descriptionLabel)
        nestedStackView.spacing = .zero
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nestedStackView)
        
        return stackView
    }
}
