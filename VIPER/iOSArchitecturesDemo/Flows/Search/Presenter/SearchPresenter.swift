//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 17.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit
import Alamofire

protocol SearchViewInput: AnyObject {
    var searchResults: [ITunesEntity] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchViewOutput: AnyObject {
    func viewDidSearch(with query: String, in type: SearchType)
    func viewDidSelectRow(_ item: ITunesEntity)
}

enum SearchType: Int {
    case apps = 0
    case music = 1
}

class SearchPresenter {
    private let interactor: SearchInteractorInput
    private let router: SearchRouterInput
    weak var viewInput: (UIViewController & SearchViewInput)?
    
    init(interactor: SearchInteractorInput, router: SearchRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    private func requestApps(with query: String) {
        interactor.requestApps(with: query) { [weak self] (result) in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            result.withValue { (apps) in
                guard !apps.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = apps
            }.withError { (error) in
                self.viewInput?.showError(error: error)
            }
        }
    }
    
    private func openAppDetails(with app: ITunesApp) {
        router.openAppDetail(for: app)
    }
    
    private func requestMusic(with query: String) {
        interactor.requestSongs(with: query) { [weak self] (result) in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            result.withValue { (songs) in
                guard !songs.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = songs
            }.withError { (error) in
                self.viewInput?.showError(error: error)
            }
        }
    }
    
    private func openSongDetails(with song: ITunesSong) {
        router.openSongDetail(for: song)
    }
}

extension SearchPresenter: SearchViewOutput {
    func viewDidSearch(with query: String, in type: SearchType) {
        switch type {
        case .apps:
            requestApps(with: query)
        case .music:
            requestMusic(with: query)
        }
    }
    
    func viewDidSelectRow(_ item: ITunesEntity) {
        if let app = item as? ITunesApp {
            openAppDetails(with: app)
        }
        
        if let song = item as? ITunesSong {
            openSongDetails(with: song)
        }
    }
}
