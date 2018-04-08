//
//  MovieListViewCell.swift
//  iMovies
//
//  Created by Yair Ivan Carreño Lizarazo on 4/6/18.
//  Copyright © 2018 qualityfull. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieListViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    func configure(for movie: Movie) {
        titleText.text = movie.title
        descriptionText.text = movie.overview
        
        if movie.poster_path != nil {
            let url = URL(string: MovieAPI.baseImageURLString + movie.poster_path!)!
            posterImage.af_setImage(withURL: url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.af_cancelImageRequest()
        posterImage.image = nil
    }
}
