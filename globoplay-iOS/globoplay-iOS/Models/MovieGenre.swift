//
//  Genres.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 17/11/24.
//

protocol Genre: Hashable {
    var title: String { get }
}

enum MovieGenre: Int, CaseIterable, Genre {
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case mystery = 9648
    case western = 37
    
    case adventure = 12
    case action = 28
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case romance = 10749
    case scienceFiction = 878
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
}

extension MovieGenre {
    var title: String {
        switch self {
        case .animation:
            return "Animação"
        case .comedy:
            return "Comédia"
        case .crime:
            return "Crime"
        case .documentary:
            return "Documentário"
        case .drama:
            return "Drama"
        case .family:
            return "Família"
        case .mystery:
            return "Mistério"
        case .western:
            return "Faroeste"
        case .adventure:
            return "Aventura"
        case .action:
            return "Ação"
        case .fantasy:
            return "Fantasia"
        case .history:
            return "História"
        case .horror:
            return "Terror"
        case .music:
            return "Música"
        case .romance:
            return "Romance"
        case .scienceFiction:
            return "Ficção Científica"
        case .tvMovie:
            return "Cinema TV"
        case .thriller:
            return "Thriller"
        case .war:
            return "Guerra"
        }
    }
}
