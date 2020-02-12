//
//  URLSession+NetworkDataLoader.swift
//  iTunesSearch
//
//  Created by Craig Swanson on 2/12/20.
//  Copyright © 2020 Craig Swanson. All rights reserved.
//

import Foundation

// created extension so it can call loadData instead of being bound to URLSession.shared
extension URLSession: NetworkDataLoader {
    
    // call loadData with our input and give us back our completion of Data? or Error?
    // create a task of self.dataTask with our request
    // call our completion with our data and error
    // resume
    func loadData(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let task = self.dataTask(with: request) { (data, _, error) in
            completion(data, error)
        }
        task.resume()
    }
}
