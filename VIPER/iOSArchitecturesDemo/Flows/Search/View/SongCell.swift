//
//  SongCell.swift
//  iOSArchitecturesDemo
//
//  Created by Vasiliy Kapyshkov on 06.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class SongCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private(set) lazy var artImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    private(set) lazy var albumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with cellModel: SongCellModel) {
        self.titleLabel.text = cellModel.title
        self.subtitleLabel.text = cellModel.artist
        self.albumLabel.text = cellModel.album
        
        if let url = cellModel.art {
            let imageDownLoader = ImageDownloader()
            
            imageDownLoader.getImage(fromUrl: url) { [weak self] (image, _) in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.artImageView.image = image
                }
            }
        }
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.titleLabel, self.subtitleLabel, self.albumLabel].forEach { $0.text = nil }
        self.artImageView.image = nil
    }
    
    private func configureUI() {
        self.addArtImageView()
        self.addTitleLabel()
        self.addSubtitleLabel()
        self.addAlbumLabel()
    }
    
    private func addArtImageView() {
        self.contentView.addSubview(self.artImageView)
        NSLayoutConstraint.activate([
            self.artImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.artImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.artImageView.widthAnchor.constraint(equalToConstant: 50),
            self.artImageView.heightAnchor.constraint(equalToConstant: 50),
            ])
    }
    
    private func addTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.artImageView.rightAnchor, constant: 10.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8.0)
            ])
    }
    
    private func addSubtitleLabel() {
        self.contentView.addSubview(self.subtitleLabel)
        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 3.0),
            self.subtitleLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
            self.subtitleLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor)
            ])
    }
    
    private func addAlbumLabel() {
        self.contentView.addSubview(self.albumLabel)
        NSLayoutConstraint.activate([
            self.albumLabel.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 3.0),
            self.albumLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
            self.albumLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor)
            ])
    }
}
