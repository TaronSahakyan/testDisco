//
//  TagsResponse.swift
//  TestDisco
//
//  Created by Taron on 19.09.22.
//

import Foundation


struct TagsResponse: Response, Decodable {
    typealias ModelType = TagModel
    enum CodingKeys:String, CodingKey {
        case data = "items"
    }
    
    let data:[TagModel]
}
