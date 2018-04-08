//
//  DataManager.swift
//  iMovies
//
//  Created by Yair Ivan Carreño Lizarazo on 4/6/18.
//  Copyright © 2018 qualityfull. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

class DataManager {
    
    func getMovies(query: String, page: String) -> Observable<MovieResponse?> {
        return MovieAPI.getMovies(query: query, page: page)
    }
}
