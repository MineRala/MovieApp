//
//  GenreCollectionViewCell.swift
//  MovieApp
//
//  Created by Mine Rala on 22.10.2022.
//

import UIKit
import MyCustomConstraints

final class GenreCollectionViewCell: UICollectionViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FuturaFont.bold.of(size: 16)
        label.textColor = Color.black
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}

// MARK: - Configure Cell
extension GenreCollectionViewCell {
    private func configureCell() {
        contentView.addSubview(titleLabel)
        titleLabel
            .leading(to: contentView, .init(constant: 4))
            .trailing(to: contentView, .init(constant: -4))
            .centerY(to: contentView)
    }
}

// MARK: - Set Cell
extension GenreCollectionViewCell {
    func setCell(title: String) {
        titleLabel.text = title
    }
}
