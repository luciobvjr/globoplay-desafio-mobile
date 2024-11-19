//
//  TVShow.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 14/11/24.
//

import SwiftData

@Model
class TVShow: Decodable, Media {
    var id: Int
    var title: String
    var genreIds: [Int]
    var posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id, title = "name", genreIds = "genre_ids", posterPath = "poster_path"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.genreIds = try container.decode([Int].self, forKey: .genreIds)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
    }
}
