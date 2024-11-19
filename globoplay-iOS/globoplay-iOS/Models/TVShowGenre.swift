//
//  TVShowGenre.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 18/11/24.
//

enum TVShowGenre: Int, CaseIterable, Genre {
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case mystery = 9648
    case western = 37
    
    case actionAndAdventure = 10759
    case kids = 10762
    case news = 10763
    case scienceFiction = 878
    case reality = 10764
    case sciFiAndFantasy = 10765
    case soap = 10766
    case talk = 10767
    case warAndPolitics = 10768
}

extension TVShowGenre {
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
        case .actionAndAdventure:
            return "Ação e Aventura"
        case .kids:
            return "Kids"
        case .news:
            return "Notícias"
        case .scienceFiction:
            return "Ficção Científica"
        case .reality:
            return "Reality"
        case .sciFiAndFantasy:
            return "Sci-Fi e Fantasia"
        case .soap:
            return "Soap"
        case .talk:
            return "Talk"
        case .warAndPolitics:
            return "Guerra e Política"
        }
    }
}
