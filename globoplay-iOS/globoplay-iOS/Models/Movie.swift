//
//  Movie.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 14/11/24.
//

struct Movie: Decodable {
    let id: Int
    let title: String
    let genre_ids: [Int]
}
