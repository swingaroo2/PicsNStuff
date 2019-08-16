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

class HttpClient {
    
    typealias RequestCompletionHandler = (Codable?, NSError?) -> ()
    typealias ImageRequestCompletionHandler = (Data?, NSError?) -> ()
    let session: URLSession
    
    init(_ session: URLSession) {
        self.session = session
    }
    
    // TODO: Better solution would be to create one get function and return data
    //       in completion handler. As this is a simple exercise, the change isn't
    //       worth the time.
    func getImage(_ imageUrl: URL, completion: @escaping ImageRequestCompletionHandler) {
        session.dataTask(with: imageUrl) { data, response, error in
            guard error == nil else {
                completion(nil, error as NSError?)
                return
            }
            
            guard let imageData = data else {
                let error = NSError(domain: "com.swingaroo2.picsnstuff", code: 500, userInfo: [NSLocalizedDescriptionKey:"Invalid image data received from the server"])
                completion(nil, error)
                return
            }
            completion(imageData, nil)
        }.resume()
    }
    
    func get(_ galleryURL: URL, completion: @escaping RequestCompletionHandler) {
        session.dataTask(with: galleryURL) { data, response, error in
            guard error == nil else {
                completion(nil, error as NSError?)
                return
            }
            
            guard let jsonData = data else {
                let error = NSError(domain: "com.swingaroo2.picsnstuff", code: 500, userInfo: [NSLocalizedDescriptionKey:"Invalid JSON data received from the server"])
                completion(nil, error)
                return
            }
            
            var gallery = JSONParser.decode(jsonData , into: Gallery.self)
            gallery?.pictures.sort { $0.published < $1.published }
            completion(gallery, nil)
            
        }.resume()
    }
    
}
