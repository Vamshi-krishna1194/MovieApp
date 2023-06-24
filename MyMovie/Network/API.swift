//
//  API.swift
//  MyMovie
//
//  Created by vamshi krishna on 24/06/23.
//

import Foundation

//class API {
//    static func loadMovies(_ page: Int, completion: @escaping ([Movie]) -> Void) {
//let session = URLSession (configuration: default)
//var str = ""
//if MovieViewModel.shared.isTodaysMovie {
//str = "https://api.themoviedb.org/3/movie/now_playing?"
//else{
//str =
//"https://api.themoviedb.org/3/movie/\MovieViewModel.shared.movies
//[MovieViewModel.shared.selectedMovieIndex].id)/similar?"
//print("string: \(str), value: \(MovieViewModel.shared.isTodaysMovie), movield:
//\(MovieViewModel.shared.movies[MovieViewModel.shared.selectedMovieIndex].id)")
//}
//var urlComponents = ULComponents (string: str)!
//let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
//let languageQuery = URLQueryItem(name: "language", value: "en-US")
//let pageQuery = URLQueryItem (name: "page", value: "\(page)")
//urlComponents.queryItems?.append(apiQuery)
//urlComponents.queryItems?.append(languageQuery)
//urlComponents.queryItems?.append(pageQuery)
//let requestURL = urlComponents.url!
//let dataTask = session.dataTask(with: requestURL) { data, response, error in
//let successRange = 200..<300
//guard error == nil,
//let statusCode = (response as? HTTPURLResponse)?.statusCode,
//successRange.contains (statusCode) else {
//completion ([])
//return
//guard let resultData = data else {
//completion([1)
//return
//let movies = API.decodeMovie (resultData)
//print ("##MovieLoad success!")
//completion (movies)
//?
//dataTask.resume ()
//            }

class NetworkManager {
    public func getMovies(completion: @escaping (_ response: Movie) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
        let url = URL(string: "\(AppConstants.baseURL)/movie/now_playing?language=en-US&page=1")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ODQzMjU0MzFjMTc2NzU5NTU5NzAxNTA2ZDVkNzUzZiIsInN1YiI6IjY0OTQ4YmEzNmI1ZmMyMDBhZDhkYmRkNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NcJsDq91vy2mhaoVKrL9RKx4J6E7cL4Q0FENphH15jk",
            "accept": "application/json"]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Movie.self, from: data)
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
                catch {
                    print(error.localizedDescription)
                    errorHandler(error)
                }
            }
        }
        task.resume()
        
    }
}
