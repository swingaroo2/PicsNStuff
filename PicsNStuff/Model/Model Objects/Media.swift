//
//  Media.swift
//  PicsNStuff
//
//  Created by Zach Lockett-Streiff on 8/15/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

struct Media: Codable {
    var imageURL: URL
    
    private enum CodingKeys: String, CodingKey {
        case imageURL = "m"
    }
}
