//
//  Picture.swift
//  PicsNStuff
//
//  Created by Zach Lockett-Streiff on 8/15/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation

struct Picture: Codable {
    var title: String
    var link: URL?
    var media: Media
    var dateTaken: Date?
    var description: String?
    var published: Date
    var author: String?
    var authorId: String?
    var tags: String?
    
    enum CodingKeys: String, CodingKey {
        case title, media, published
    }
}
