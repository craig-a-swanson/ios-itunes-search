//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Craig Swanson on 11/1/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    // format should be:  https://itunes.apple.com/search?term=Tora&media=movie
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "media", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTypeQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil.")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data returned from the data task")
                completion(NSError())
                return
            }
            
            do {
                print(requestURL)
                let jsonDecoder = JSONDecoder()
                let mediaSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults.append(contentsOf: mediaSearch.results)
                completion(nil)
            } catch {
                print("Unable to decode data into object of type [SearchResult]")
                completion(error)
            }
            completion(nil)
        }.resume()
        
    }
}
