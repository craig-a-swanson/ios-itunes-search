//
//  iTunesSearchTests.swift
//  iTunesSearchTests
//
//  Created by Craig Swanson on 2/12/20.
//  Copyright © 2020 Craig Swanson. All rights reserved.
//

import XCTest
@testable import iTunesSearch

// Does decoding work?
// Does decoding fail when given bad data?
// Does it build the correct URL?
// Does it build the correct URLRequest?
// Are the results saved properly?
// Is completion handler called if the networking fails
// is completion handler called if the data is bad?  and if the data is good?

class iTunesSearchTests: XCTestCase {
    
    func testForSomeNetworkResults() {
        
        let controller = SearchResultController()
        let resultsExpectation = expectation(description: "Wait for search results")
        
        controller.performSearch(searchTerm: "Bad Bad Hats", resultType: .musicTrack) {
            resultsExpectation.fulfill()
        }
        wait(for: [resultsExpectation], timeout: 2)
        
        // Now check results
        XCTAssertTrue(controller.searchResults.count == 10, "Expecting 10 results for Bad Bad Hats.")
        XCTAssertEqual("Midway", controller.searchResults[0].title)
    }
    
    func testForSomeResults() {
        let mock = MockDataLoader()
        mock.data = goodResultsData
        
        let controller = SearchResultController(dataLoader: mock)
        let resultsExpectation = expectation(description: "Wait for search results")
        
        controller.performSearch(searchTerm: "Bad Bad Hats", resultType: .musicTrack) {
            resultsExpectation.fulfill()
        }
        wait(for: [resultsExpectation], timeout: 2)
        
        // Now check results
        XCTAssertTrue(controller.searchResults.count == 10, "Expecting 10 results for Bad Bad Hats.")
        XCTAssertEqual("Midway", controller.searchResults[0].title)
    }
    
    func testForBadResults() {
        let mock = MockDataLoader()
        mock.data = badResultsData
        let controller = SearchResultController(dataLoader: mock)
        
        let resultsExpectation = expectation(description: "Wait for search results")
        
        controller.performSearch(searchTerm: "Bad Bad Hats", resultType: .musicTrack) {
            resultsExpectation.fulfill()
        }
        
        wait(for: [resultsExpectation], timeout: 2)
        
        XCTAssertTrue(controller.searchResults.count == 0, "Expecting no results for Bad Bad Hats using bad data")
        print(controller.error)
        XCTAssertNotNil(controller.error)
    }
    
    func testNoResults() {
        let mock = MockDataLoader()
        mock.data = noResultsData
        let controller = SearchResultController(dataLoader: mock)
        
        let resultsExpectation = expectation(description: "Wait for search results")
        
        controller.performSearch(searchTerm: "abcdefg123", resultType: .musicTrack) {
            resultsExpectation.fulfill()
        }
        
        wait(for: [resultsExpectation], timeout: 2)
        
        XCTAssertTrue(controller.searchResults.count == 0)
        XCTAssertNil(controller.error)
    }

}
