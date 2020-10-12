//
//  AlbumCollectionViewCell.swift
//  TypicodePhotoCollection
//
//  Created by Oliver Jordy Pérez Escamilla on 11/10/20.
//

import UIKit
import Kingfisher

final class AlbumCollectionViewCell: UICollectionViewCell {

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
        imageView.layer.cornerRadius = 8.0
    }
    
    // MARK: - Internal methods
    func setImage(from url: URL) {
        imageView.kf.setImage(
            with: url,
            options: [
                .transition(.fade(0.5))
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
        textLabel.font = textLabel.font.withSize(14.0)
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
