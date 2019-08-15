//
//  FlickrService.swift
//  PicsNStuff
//
//  Created by Zach Lockett-Streiff on 8/15/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class FlickrService: NSObject {
    
    typealias ServiceCompletionHandler = (Gallery?, NSError?) -> ()
    
    // Force-unwrapped for the purposes of this simple exercise, since the correct URL is known in advance
    let feedURL = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json")!
    var gallery: Gallery?
    
    // TODO: Consider HttpClient class
    func initiate(completion: @escaping ServiceCompletionHandler) {
        let session = URLSession(configuration: .default)
        let httpClient = HttpClient(session)
        httpClient.get(feedURL) { gallery, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let gallery = gallery else {
                let error = NSError(domain: "com.swingaroo2.picsnstuff", code: 500, userInfo: [NSLocalizedDescriptionKey:"Failed to parse JSON from the server"])
                completion(nil, error)
                return
            }
            completion(gallery as? Gallery, error)
            
        }
    }
    
}

// TODO: Put this in its own class
class HttpClient {
    
    typealias RequestCompletionHandler = (Codable?, NSError?) -> ()
    let session: URLSession
    
    init(_ session: URLSession) {
        self.session = session
    }
    
    func get(_ url: URL, completion: @escaping RequestCompletionHandler) {
        URLSession(configuration: .default).dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil, error as NSError?)
                return
            }
            
            guard let jsonData = data else {
                let error = NSError(domain: "com.swingaroo2.picsnstuff", code: 500, userInfo: [NSLocalizedDescriptionKey:"Invalid JSON data received from the server"])
                completion(nil, error)
                return
            }
            
            let gallery = JSONParser.decode(jsonData , into: Gallery.self)
            completion(gallery, nil)
            
        }.resume()
    }
    
}
