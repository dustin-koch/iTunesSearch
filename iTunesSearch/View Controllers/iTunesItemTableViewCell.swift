//
//  iTunesItemTableViewCell.swift
//  iTunesSearch
//
//  Created by Dustin Koch on 5/16/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class iTunesItemTableViewCell: UITableViewCell {
    
    var iTunesResult: iTunesResults? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    
    func updateViews(){
        guard let iTunesResult = iTunesResult else { return }
        
        trackLabel.text = iTunesResult.track
        artistLabel.text = iTunesResult.artist
        albumLabel.text = iTunesResult.album
    }
    
    
}//End of class
