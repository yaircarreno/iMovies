//
//  MovieDetailCoordinator.swift
//  iMovies
//
//  Created by Yair Ivan Carreño Lizarazo on 4/7/18.
//  Copyright © 2018 qualityfull. All rights reserved.
//

import Foundation
import RxSwift

class MovieDetailCoodinator:  Coordinator<Bool> {
    
    private let rootViewController: UINavigationController
    private let movie: Movie?
    
    init(rootViewController: UINavigationController, movie: Movie) {
        self.rootViewController = rootViewController
        self.movie = movie
    }
    
    override func start() -> Bool {
        
        guard let movie = self.movie else {
            return false
        }
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return false
        }
        
        let viewModel = MovieDetailViewModel(movie: movie)
        viewController.viewModel = viewModel
        rootViewController.pushViewController(viewController, animated: true)
        
        return true
    }
}
