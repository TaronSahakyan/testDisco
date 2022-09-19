//
//  TagModel.swift
//  TestDisco
//
//  Created by Taron on 19.09.22.
//

import Foundation

struct TagModel: Decodable {
//    enum CodingKey:CodingKeys {
//
//    }
    var name:String
    var count: Int
    var isRequired:Bool
    var isModeratorOnly: Bool
    var hasSynonyms:Bool
}
