//
//  PlaybackViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Vasiliy Kapyshkov on 11.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

protocol PlaybackViewModelInput {
    func play()
    func pause()
    func stop()
}

protocol PlaybackViewModelOutput {
    var onProgressChanged: ((Float) -> Void)? { get set }
}


class PlaybackViewModel: PlaybackViewModelOutput {
    var onProgressChanged: ((Float) -> Void)?
    var timer: Timer?
    var progress: Float {
        didSet {
            onProgressChanged?(progress)
        }
    }
    
    init(progress: Float, onProgressChanged: ((Float) -> Void)?) {
        self.progress = progress
        self.onProgressChanged = onProgressChanged
        self.onProgressChanged?(progress)
    }
}


extension PlaybackViewModel: PlaybackViewModelInput {
    func play() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] timer in
            guard let self = self else { return }

            let newProgress = self.progress + 0.05

            if self.progress == 1 {
                timer.invalidate()
            }
            self.progress = min(newProgress, 1)
        })
    }
    
    func pause() {
        timer?.invalidate()
    }
    
    func stop() {
        timer?.invalidate()
        progress = 0
    }
    
    
}
