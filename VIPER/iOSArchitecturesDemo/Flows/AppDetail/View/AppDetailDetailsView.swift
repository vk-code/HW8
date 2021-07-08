//
//  AppDetailDetailsView.swift
//  iOSArchitecturesDemo
//
//  Created by Vasiliy Kapyshkov on 06.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailDetailsView: UIView {
    
    private(set) lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.numberOfLines = 10
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.addSubview(sizeLabel)
        self.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            sizeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            sizeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            sizeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            
            descriptionLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 12),
            descriptionLabel.leftAnchor.constraint(equalTo: sizeLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: sizeLabel.rightAnchor),
        ])
    }
}
