//
//  Gallery.swift
//  PicsNStuff
//
//  Created by Zach Lockett-Streiff on 8/15/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

struct Gallery: Codable {
    var title: String
    var link: URL?
    var description: String?
    var modified: Date?
    var generator: String?
    var items: [Picture]
    
    private enum CodingKeys: String, CodingKey {
        case title, items
    }
}
