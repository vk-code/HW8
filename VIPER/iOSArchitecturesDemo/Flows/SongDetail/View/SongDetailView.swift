//
//  SongDetailView.swift
//  iOSArchitecturesDemo
//
//  Created by Vasiliy Kapyshkov on 11.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class SongDetailView: UIView {
    
    private lazy var btnImgConf = UIImage.SymbolConfiguration(pointSize: 30)
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .red
        progressView.progress = 0
        progressView.backgroundColor = .white
        return progressView
    }()
    
    private(set) lazy var playBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "play", withConfiguration: btnImgConf), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    private(set) lazy var pauseBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "pause", withConfiguration: btnImgConf), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    private(set) lazy var stopBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "stop", withConfiguration: btnImgConf), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .black
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(progressView)
        addSubview(playBtn)
        addSubview(pauseBtn)
        addSubview(stopBtn)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20.0),
            imageView.widthAnchor.constraint(equalToConstant: 220),
            imageView.heightAnchor.constraint(equalToConstant: 220),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15.0),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30.0),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30.0),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),

            progressView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 25),
            progressView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30.0),
            progressView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30.0),
            
            pauseBtn.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 25),
            pauseBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            playBtn.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 25),
            playBtn.rightAnchor.constraint(equalTo: pauseBtn.leftAnchor, constant: -30),
            
            stopBtn.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 25),
            stopBtn.leftAnchor.constraint(equalTo: pauseBtn.rightAnchor, constant: 30)
        ])
    }
}
