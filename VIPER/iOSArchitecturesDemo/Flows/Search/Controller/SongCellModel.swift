//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Vasiliy Kapyshkov on 06.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

struct SongCellModel {
    let title: String
    let artist: String?
    let album: String?
    let art: String?
}

final class SongCellModelFactory {
    
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(title: model.trackName,
                             artist: "by \(model.artistName!)",
                             album: model.collectionName,
                             art: model.artwork)
    }
}
