//
//  MockDataLoader.swift
//  iTunesSearchTests
//
//  Created by Craig Swanson on 2/12/20.
//  Copyright © 2020 Craig Swanson. All rights reserved.
//

import Foundation
@testable import iTunesSearch

class MockDataLoader: NetworkDataLoader {
    var request: URLRequest?
    var data: Data?
    var error: Error?
    
    func loadData(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        self.request = request
        DispatchQueue.main.async {
            completion(self.data, self.error)
        }
    }
}
