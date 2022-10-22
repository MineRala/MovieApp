//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Mine Rala on 17.10.2022.
//

import UIKit
import SnapKit
import Kingfisher

private enum MovieTableViewCellConstnt {
    static let viewColor = Color.cellBackgrounColor
    static let borderColor = Color.black
}

final class MovieTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = MovieTableViewCellConstnt.viewColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = MovieTableViewCellConstnt.borderColor.withAlphaComponent(0.3).cgColor
        view.layer.cornerRadius = 12
        return view
    }()

    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FuturaFont.bold.of(size: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FuturaFont.condesedMedium.of(size: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FuturaFont.medium.of(size: 12)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var typeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray.withAlphaComponent(0.5)
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
        typeLabel.text = nil
        yearLabel.text = nil
    }
}

extension MovieTableViewCell {
    private func configureCell() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.right.equalToSuperview()
        }
        
        containerView.addSubview(posterImageView)
        
        posterImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.top.left.equalToSuperview().offset(8)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.top)
            make.left.equalTo(posterImageView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        containerView.addSubview(typeView)
        
        typeView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(titleLabel.snp.left)
            make.height.equalToSuperview().multipliedBy(0.15)
            make.width.equalToSuperview().multipliedBy(0.20)
        }
        
        typeView.addSubview(typeLabel)
        
        typeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        containerView.addSubview(yearLabel)
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(typeView.snp.bottom).offset(8)
            make.left.equalTo(typeView.snp.left).offset(8)
            make.height.equalTo(32)
            make.width.equalTo(80)
        }
    }
}

//MARK: - Set Cell
extension MovieTableViewCell {
    func setCell(model: Search) {
        if model.poster == "N/A" {
            posterImageView.image = UIImage(named: "NoImage")
        } else {
            posterImageView.kf.setImage(with: URL(string: model.poster))
        }
        titleLabel.text = model.title
        typeLabel.text = model.type
        yearLabel.text = model.year
       
    }
}
