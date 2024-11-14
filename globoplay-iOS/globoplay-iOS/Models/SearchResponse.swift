//
//  SearchResponse.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 14/11/24.
//

struct SearchResponse<T: Decodable>: Decodable {
    let page: Int
    let results: [T]
}
