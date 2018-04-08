//
//  MovieDetailViewController.swift
//  iMovies
//
//  Created by Yair Ivan Carreño Lizarazo on 4/7/18.
//  Copyright © 2018 qualityfull. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage


class MovieDetailViewController: UIViewController {
    
    var viewModel: MovieDetailViewModel?

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func bindToRx() {
        self.titleText.text = self.viewModel?.movie?.title
        self.overviewText.text = self.viewModel?.movie?.overview
        
        if self.viewModel?.movie?.poster_path != nil {
            let url = URL(string: MovieAPI.baseImageURLString + (self.viewModel?.movie?.poster_path)!)!
            posterImage.af_setImage(withURL: url)
        }
    }
}
