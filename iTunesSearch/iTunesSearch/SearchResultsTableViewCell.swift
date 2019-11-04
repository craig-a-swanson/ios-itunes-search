//
//  SearchResultsTableViewCell.swift
//  iTunesSearch
//
//  Created by Craig Swanson on 11/1/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    // MARK: Properties
    var searchResult: SearchResult? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: Outlets
    @IBOutlet weak var mediaTitleLabel: UILabel!
    @IBOutlet weak var mediaCreatorLabel: UILabel!
    
    
    // MARK: Methods
    func updateViews() {
        guard let searchResult = searchResult else { return }
        mediaTitleLabel.text = searchResult.title
        mediaCreatorLabel.text = searchResult.creator
    }
    

}
