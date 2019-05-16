//
//  iTunesResultsController.swift
//  iTunesSearch
//
//  Created by Dustin Koch on 5/16/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class iTunesResultsController {
    
    static let baseURL = URL(string: "https://itunes.apple.com/")
    
    static func searchiTunesFor(searchTerm: String, completion: @escaping ([iTunesResults]) -> Void ) {
        //make URL
        guard var url = baseURL else { completion([]); return }
        url.appendPathComponent("search")
        //break URL down for search capability and build back up
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let termQuery = URLQueryItem(name: "term", value: searchTerm)
        let musicQuery = URLQueryItem(name: "media", value: "music")
        components?.queryItems = [termQuery, musicQuery]
        guard let finalURL = components?.url else { completion([]); return }
        //data task with new, final URL
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            guard let data = data else { completion([]); return }
            let jsonDecoder = JSONDecoder()
            
            do {
                let topLevelJSON = try jsonDecoder.decode(TopLevelJSON.self, from: data)
                let iTunesResults = topLevelJSON.results
                completion(iTunesResults)
            } catch {
                print(error.localizedDescription)
                completion([])
                return
            }
        }.resume()
    }//End of search fetch
    
    static func fetchImageFor(iTunesResult: iTunesResults, completion: @escaping (UIImage?) -> Void ) {
        let url = iTunesResult.imageURL
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data else { completion(nil); return }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }//End of image fetch
    
    
}
