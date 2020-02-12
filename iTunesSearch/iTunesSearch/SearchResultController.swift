//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Craig Swanson on 11/1/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: Properties
    // NOTE: in DI update, we added a reference to the NetworkDataLoader and initialize it. The default is URLSession.shared, but we will also be able to pass our own dataLoader when testing.
    let dataLoader: NetworkDataLoader
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    var error: Error?
    
    init(dataLoader: NetworkDataLoader = URLSession.shared) {
        self.dataLoader = dataLoader
    }
    
    
    // MARK: Methods
    // format should be:  https://itunes.apple.com/search?term=Tora&media=movie
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "media", value: resultType.rawValue)
        let resultsShown = URLQueryItem(name: "limit", value: "10")
        urlComponents?.queryItems = [searchTermQueryItem, resultTypeQueryItem, resultsShown]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil.")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        // NOTE: in the DI update, we removed the URLSession.shared.dataTask with a call to the dataLoader.loadData
        self.dataLoader.loadData(with: request) { data, error in
            
            // NOTE: in the DI update, we did not change any of the data task code.
            if let error = error {
                print("Error fetching data \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned from the data task")
                completion()
                return
            }
     
            do {
                let jsonDecoder = JSONDecoder()
                let mediaSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = mediaSearch.results
            } catch {
                print("Unable to decode data into object of type [SearchResult]")
                self.error = error
            }
            completion()
        }
        
    }
}
