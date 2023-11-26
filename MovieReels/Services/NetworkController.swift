//
//  NetworkController.swift
//  MovieReels
//
//  Created by Apple M1 on 26.11.2023.
//

import Foundation

enum NetErrors: Error {
    case statusCode(Int)
    case invalidURL
    case invalidData
    case badResponce
    case wrongDecode
    case connectionProblem
}

class NetworkController: MovieFetching {
    
    let baseUrl = "https://api.themoviedb.org/"
    let apiKey = "ab33d4e999f999ccf72a3004bf245514"
    let language = "en-US"
    
    let session = URLSession.shared
    let headers = ["accept": "application/json",
                   "Authorization": "Bearer ab33d4e999f999ccf72a3004bf245514"
    ]
    
    lazy var decoder = JSONDecoder()
    
    func fetchData(fullPath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: fullPath) else {
            completion(.failure(NetErrors.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        print(fullPath)
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(NetErrors.connectionProblem))
                print("1")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetErrors.badResponce))
                print("2")
                return
            }
            
            let stausCode = httpResponse.statusCode
            
            guard (200..<300).contains(stausCode) else {
                completion(.failure(NetErrors.statusCode(stausCode)))
                print("3")
                return
            }
            
            guard let data else {
                completion(.failure(NetErrors.invalidData))
                print("4")
                return
            }
            
            completion(.success(data))
        }
        dataTask.resume()
    }
    
    func fetchData(path: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = baseUrl.appending(path)
        fetchData(fullPath: urlString, completion: completion)
    }
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let path = "3/trending/movie/day?language=\(language)&api_key=\(apiKey)"
        
        fetchData(path: path) { response in
            do {
                let data = try response.get()
                let responseData = try self.decoder.decode(MovieReelDTO.self, from: data)
                let moviesDto = responseData.results
                
                let movies = moviesDto.map { movie in
                    Movie(id: movie.id,
                          title: movie.title,
                          overview: movie.overview,
                          posterPath: movie.posterPath,
                          genres: movie.genres,
                          popularity: movie.popularity,
                          releaseDate: movie.releaseDate,
                          voteAverage: movie.voteAverage,
                          voteCount: movie.voteCount)
                }
                completion(.success(movies))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }
}
