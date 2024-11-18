//
//  TVShow.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 14/11/24.
//

import SwiftData

@Model
class TVShow: Decodable {
    var id: Int
    var name: String
    var genre_ids: [Int]
    
    enum CodingKeys: CodingKey {
        case id, name, genre_ids
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.genre_ids = try container.decode([Int].self, forKey: .genre_ids)
    }
}
