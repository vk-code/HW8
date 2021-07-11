//
//  SearchBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 17.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class SearchBuilder {
    
    static func build() -> (UIViewController & SearchViewInput) {
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(interactor: interactor, router: router)
        let viewController = SearchViewController(presenter: presenter)
        
        presenter.viewInput = viewController
        router.viewController = viewController
        
        return viewController
    }
    
}
