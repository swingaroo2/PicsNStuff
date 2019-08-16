//
//  ImageService.swift
//  PicsNStuff
//
//  Created by Zach Lockett-Streiff on 8/16/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

class ImageService: NSObject {
    
    typealias ImageServiceCompletionHandler = (UIImage?, NSError?) -> ()
    private let imageURL: URL
    private var image: UIImage?
    
    @objc init(_ imageURL: URL) {
        self.imageURL = imageURL
    }
    
    @objc func initiate(completion: @escaping ImageServiceCompletionHandler) {
        let session = URLSession(configuration: .default)
        HttpClient(session).getImage(imageURL) { data, error in
            guard error == nil else {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            guard let imageData = data else {
                let error = NSError(domain: "com.swingaroo2.picsnstuff", code: 500, userInfo: [NSLocalizedDescriptionKey:"Invalid image data received from the server"])
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async { completion(image, nil) }
        }
    }
}
