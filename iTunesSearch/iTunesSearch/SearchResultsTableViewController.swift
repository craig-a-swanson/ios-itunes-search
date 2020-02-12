//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Craig Swanson on 11/1/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: Properties
    let searchResultsController = SearchResultController()
    
    
    // MARK: Outlets
    @IBOutlet weak var mediaSelectionControl: UISegmentedControl!
    @IBOutlet weak var searchField: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaResultsCell", for: indexPath) as? SearchResultsTableViewCell else { return UITableViewCell() }
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.searchResult = searchResult

        return cell
    }
    
    
    // MARK: Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchField = searchField.text else { return }
        var resultType: ResultType!
        
        switch mediaSelectionControl.selectedSegmentIndex {
        case 0:
            resultType = .software
            searchResultsController.performSearch(searchTerm: searchField, resultType: resultType) {
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        case 1:
            resultType = .musicTrack
            searchResultsController.performSearch(searchTerm: searchField, resultType: resultType) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        case 2:
            resultType = .movie
            searchResultsController.performSearch(searchTerm: searchField, resultType: resultType) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        default:
            print("No media type was selected.")
        }
    }

}
