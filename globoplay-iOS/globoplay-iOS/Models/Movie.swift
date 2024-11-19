//
//  Movie.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 14/11/24.
//

import SwiftData

protocol Media: Decodable {
    var id: Int { get }
    var title: String { get }
    var genreIds: [Int] { get }
    var posterPath: String? { get }
    var overview: String { get }
}

@Model
class Movie: Decodable, Media {
    var id: Int
    var title: String
    var genreIds: [Int]
    var posterPath: String?
    var overview: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, genreIds = "genre_ids", posterPath = "poster_path", overview
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.genreIds = try container.decode([Int].self, forKey: .genreIds)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        self.overview = try container.decode(String.self, forKey: .overview)
    }
    
    init(id: Int, title: String, genreIds: [Int], posterPath: String, overview: String) {
        self.id = id
        self.title = title
        self.genreIds = genreIds
        self.posterPath = posterPath
        self.overview = overview
    }
}
