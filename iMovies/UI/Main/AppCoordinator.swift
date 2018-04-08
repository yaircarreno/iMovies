//
//  AppCoordinator.swift
//  iMovies
//
//  Created by Yair Ivan Carreño Lizarazo on 4/7/18.
//  Copyright © 2018 qualityfull. All rights reserved.
//

import Foundation
import RxSwift

class AppCoordinator: Coordinator<Bool> {
    
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private let movieListCoordinator: MovieListCoordinator
    private let disposeBag = DisposeBag()
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.movieListCoordinator = MovieListCoordinator(navigationController: rootViewController)
    }
    
    override func start() -> Bool {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        coordinate(to: movieListCoordinator)
            .subscribe({ result in
                switch result {
                case .success(let r):
                    print("Coordinated by AppCoodinator: \(r)")
                case .error(let error):
                    print("Error coordinating AppCoodinator: ", error)
                }
            })
            .disposed(by: disposeBag)
        return true
    }
}
