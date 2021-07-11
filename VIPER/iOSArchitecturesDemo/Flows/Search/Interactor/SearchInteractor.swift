//
//  SearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Vasiliy Kapyshkov on 11.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation
import Alamofire

protocol SearchInteractorInput {
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void)
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void)
}


class SearchInteractor: SearchInteractorInput {
    private let searchService = ITunesSearchService()
    private var cacheApps: [String:Result<[ITunesApp]>] = [:]
    private var cacheSongs: [String:Result<[ITunesSong]>] = [:]
    
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void) {
        if let cached = cacheApps[query] {
            completion(cached)
        } else {
            searchService.getApps(forQuery: query, then: completion) { [weak self] result in
                self?.cacheApps[query] = result
            }
        }
    }
    
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        if let cached = cacheSongs[query] {
            completion(cached)
        } else {
            searchService.getSongs(forQuery: query, completion: completion) { [weak self] result in
                self?.cacheSongs[query] = result
            }
        }
    }
}
