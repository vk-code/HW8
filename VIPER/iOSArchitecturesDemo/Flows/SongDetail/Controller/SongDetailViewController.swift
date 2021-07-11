//
//  SongDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Vasiliy Kapyshkov on 11.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class SongDetailViewController: UIViewController {
    
    var viewModel: PlaybackViewModel?
    private let song: ITunesSong
    private var songDetailView: SongDetailView {
        return self.view as! SongDetailView
    }
    
    init(with song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = SongDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.93)
        
        setSongData()
        
        viewModel = PlaybackViewModel(progress: 0, onProgressChanged: { [weak self] progress in
            self?.songDetailView.progressView.setProgress(progress, animated: true)
        })
    }
    
    private func setSongData() {
        if let url = song.artwork {
            let imageDownLoader = ImageDownloader()
            
            imageDownLoader.getImage(fromUrl: url) { [weak self] (image, _) in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.songDetailView.imageView.image = image
                }
            }
        }
        
        songDetailView.titleLabel.text = song.trackName
        songDetailView.subtitleLabel.text = "by \(song.artistName ?? "Unknown Artist")"
        songDetailView.playBtn.addTarget(self, action: #selector(play), for: .touchUpInside)
        songDetailView.pauseBtn.addTarget(self, action: #selector(pause), for: .touchUpInside)
        songDetailView.stopBtn.addTarget(self, action: #selector(stop), for: .touchUpInside)
    }
    
    @objc func play() {
        viewModel?.play()
    }
    
    @objc func pause() {
        viewModel?.pause()
    }
    
    @objc func stop() {
        viewModel?.stop()
    }
    
    deinit {
        songDetailView.playBtn.removeTarget(nil, action: nil, for: .allEvents)
        songDetailView.pauseBtn.removeTarget(nil, action: nil, for: .allEvents)
        songDetailView.stopBtn.removeTarget(nil, action: nil, for: .allEvents)
    }
}
