//
//  NetworkDataLoader.swift
//  iTunesSearch
//
//  Created by Craig Swanson on 2/12/20.
//  Copyright © 2020 Craig Swanson. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
    // Question: What do we need for data in and data out?
    // What do we need back: Possible Data and Possible Error
    // What do we need to provide: URLRequest
    
    func loadData(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}
