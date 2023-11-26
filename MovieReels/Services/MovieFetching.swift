//
//  MovieFetching.swift
//  MovieReels
//
//  Created by Apple M1 on 26.11.2023.
//

import Foundation

protocol MovieFetching {
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}
