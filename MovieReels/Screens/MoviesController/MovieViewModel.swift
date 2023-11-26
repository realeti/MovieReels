//
//  MovieViewModel.swift
//  MovieReels
//
//  Created by Apple M1 on 12.11.2023.
//

import UIKit

class MovieViewModel: MovieViewProtocol {
    
    var movies: [Movie] = []
    let networkController = NetworkController()
    
    func loadNetworkData() {
        networkController.fetchMovies { [weak self] result in
            do {
                let moviesData = try result.get()
                self?.movies = moviesData
            } catch {
                self?.movies = []
            }
            
            DispatchQueue.main.async {
                print(self?.movies as Any)
            }
        }
    }
}
