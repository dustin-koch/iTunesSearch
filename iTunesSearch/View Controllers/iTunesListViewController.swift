//
//  iTunesListViewController.swift
//  iTunesSearch
//
//  Created by Dustin Koch on 5/16/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class iTunesListViewController: UIViewController {
    
    var results: [iTunesResults] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}//End of class

extension iTunesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iTunesResultCell", for: indexPath) as? iTunesItemTableViewCell
        let result = results[indexPath.row]
        cell?.iTunesResult = result
        cell?.artworkImageView.image = nil
        iTunesResultsController.fetchImageFor(iTunesResult: result) { (image) in
            DispatchQueue.main.async {
                cell?.artworkImageView.image = image
            }
        }
        return cell ?? UITableViewCell()
    }
}

extension iTunesListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        iTunesResultsController.searchiTunesFor(searchTerm: searchTerm) { (results) in
            self.results = results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
