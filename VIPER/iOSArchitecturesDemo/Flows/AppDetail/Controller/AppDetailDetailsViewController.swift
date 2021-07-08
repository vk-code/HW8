//
//  AppDetailDetailsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Vasiliy Kapyshkov on 06.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailDetailsViewController: UIViewController {
    
    private let app: ITunesApp
    
    private var appDetailDetailsView: AppDetailDetailsView {
        return self.view as! AppDetailDetailsView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailDetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
    }
    
    private func fillData() {
        let appSize = Float(app.size!) / 1024 / 1024
        appDetailDetailsView.sizeLabel.text = "Размер приложения: \( String(format: "%.2f", appSize) ) Mb"
        appDetailDetailsView.descriptionLabel.text = app.appDescription
    }
}
