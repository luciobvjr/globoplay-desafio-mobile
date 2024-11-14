//
//  MediaType.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 14/11/24.
//

enum MediaType: String, CaseIterable, Identifiable {
    case tv, movie
    
    var id: Self { self }
    
    var displayName: String {
        switch self {
        case .tv:
            return "Séries"
        case .movie:
            return "Filmes"
        }
    }
}
