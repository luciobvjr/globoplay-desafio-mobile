//
//  Movie.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 14/11/24.
//

import SwiftData

@Model
class Movie: Decodable {
    var id: Int
    var title: String
    var genre_ids: [Int]
    var poster_path: String
    
    enum CodingKeys: CodingKey {
        case id, title, genre_ids, poster_path
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.genre_ids = try container.decode([Int].self, forKey: .genre_ids)
        self.poster_path = try container.decode(String.self, forKey: .poster_path)
    }
}
