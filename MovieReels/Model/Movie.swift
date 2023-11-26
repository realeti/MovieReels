//
//  Movie.swift
//  MovieReels
//
//  Created by Apple M1 on 26.11.2023.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let genres: [Int]
    let popularity: Double
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
}
