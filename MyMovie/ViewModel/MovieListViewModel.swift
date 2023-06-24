//
//  MovieListViewModel.swift
//  MyMovie
//
//  Created by vamshi krishna on 24/06/23.
//

import Foundation
import UIKit

class MovieListViewModel: ObservableObject {
    
    var movies: Movie?
    
    private let networkManager = NetworkManager()
    
    func getMoviesData(collectionView: UICollectionView) {
        networkManager.getMovies { response in
            DispatchQueue.main.async {
                self.movies = response
                collectionView.reloadData()
            }
        } errorHandler: { error in
            print(error.localizedDescription)
        }
    }
    
}
