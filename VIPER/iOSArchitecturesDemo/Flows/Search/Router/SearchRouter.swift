//
//  SearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Vasiliy Kapyshkov on 11.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchRouterInput {
    func openAppDetail(for app: ITunesApp)
    func openSongDetail(for song: ITunesSong)
}

class SearchRouter: SearchRouterInput {
    weak var viewController: UIViewController?
    
    func openAppDetail(for app: ITunesApp) {
        let vc = AppDetailViewController(app: app)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSongDetail(for song: ITunesSong) {
        let vc = SongDetailViewController(with: song)
        viewController?.present(vc, animated: true, completion: nil)
    }
}
