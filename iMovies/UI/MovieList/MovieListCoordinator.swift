//
//  MovieListCoordinator.swift
//  iMovies
//
//  Created by Yair Ivan Carreño Lizarazo on 4/7/18.
//  Copyright © 2018 qualityfull. All rights reserved.
//

import Foundation
import RxSwift

class MovieListCoordinator: Coordinator<Bool> {
    
    private let navigationController: UINavigationController
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Bool {
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController else {
            return false
        }
        
        let viewModel = MovieListViewModel(datamanager: DataManager())
        
        bindEvents(viewModel: viewModel)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
        
        return true
    }
    
    private func bindEvents(viewModel: MovieListViewModel) -> Void {
        
        viewModel.selectedSubject
            .flatMap{ self.showMovieDetail(on: self.navigationController, movie: $0)}
            .subscribe(onNext: {
                result in print("Coordinated by MovieListCoordinator: \(result)")
            }, onError: {
                error in print("Error binding events: ", error)
            })
            .disposed(by: disposeBag)
    }
    
    private func showMovieDetail(on rootViewController: UINavigationController, movie: Movie) -> Single<Bool> {
        let movieDetailCoodinator = MovieDetailCoodinator(rootViewController: rootViewController, movie: movie)
        return coordinate(to: movieDetailCoodinator)
    }
}
