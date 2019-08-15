//
//  JSONParser.swift
//  PicsNStuff
//
//  Created by Zach Lockett-Streiff on 8/15/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

class JSONParser {
    class func decode<T>(_ jsonData: Data?, into type: T.Type) -> T? where T: Decodable {
        guard let data = JSONParser.sanitize(jsonData) else {
            
            print("Invalid or nonexistent data")
            return nil
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let decoded = try decoder.decode(type, from: data)
            print("Successfully decoded \(T.self)")
            return decoded
        } catch {
            // TODO: Error handling (notification?)
            print("Unable to decode \(T.self)\n: \(error)")
        }
        
        return nil
    }
    
    class func sanitize(_ jsonData: Data?) -> Data? {
        guard let data = jsonData else { return nil }
        guard let jsonString = String(data: data, encoding: .utf8) else { return nil }
        let noPrefixString = jsonString.replacingOccurrences(of: "jsonFlickrFeed(", with: "")
        let sanitizedString = noPrefixString.dropLast()
        let validData = sanitizedString.data(using: .utf8)
        return validData
    }
}

