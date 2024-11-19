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
    
    var originalTitle: String? { get }
    var releaseDate: String? { get }
    var voteAverage: Double? { get }
    var voteCount: Int? { get }
}

@Model
class Movie: Decodable, Media {
    var id: Int
    var title: String
    var genreIds: [Int]
    var posterPath: String?
    var overview: String
    
    var originalTitle: String?
    var releaseDate: String?
    var voteAverage: Double?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id,
             title,
             genreIds = "genre_ids",
             posterPath = "poster_path",
             overview,
             originalTitle = "original_title",
             releaseDate = "release_date",
             voteAverage = "vote_average",
             voteCount = "vote_count"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.genreIds = try container.decode([Int].self, forKey: .genreIds)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        self.overview = try container.decode(String.self, forKey: .overview)
        
        self.originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
    }
}
