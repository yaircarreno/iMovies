//
//  MovieListViewModel.swift
//  iMovies
//
//  Created by Yair Ivan Carreño Lizarazo on 4/6/18.
//  Copyright © 2018 qualityfull. All rights reserved.
//

import Foundation
import RxSwift

class MovieListViewModel {
    
    private let bag = DisposeBag()
    fileprivate let datamanager: DataManager
    
    let selectedSubject = PublishSubject<Movie>()
    
    // MARK: Init
    init(datamanager: DataManager) {
        self.datamanager = datamanager
    }
    
    func selectedItemCell(movie: Movie) -> Void {
        selectedSubject.onNext(movie)
    }
    
    func getMovieList() -> Observable<[Movie]> {
        return self.datamanager
            .getMovies(query: "Game", page: "1")
            .map{ ($0?.results)! }
    }
}
