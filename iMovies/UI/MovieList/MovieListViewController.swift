//
//  MovieListViewController.swift
//  iMovies
//
//  Created by Yair Ivan Carreño Lizarazo on 4/1/18.
//  Copyright © 2018 qualityfull. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: UIViewController {
    
    var viewModel: MovieListViewModel?
    private let disposeBag = DisposeBag()

    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableToRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func bindTableToRx() {
        
        viewModel?.getMovieList()
            .observeOn(MainScheduler.instance)
            .bind(to: movieTableView.rx.items(cellIdentifier: "movieListViewCell",
                                              cellType: MovieListViewCell.self))
            { (_, movie, cell) in
                cell.configure(for: movie)
            }
            .disposed(by: disposeBag)
        
        movieTableView.rx.modelSelected(Movie.self)
            .subscribe(onNext: { [weak self] movie in
                self?.viewModel?.selectedItemCell(movie: movie)
            })
            .disposed(by: disposeBag)
    }
}
