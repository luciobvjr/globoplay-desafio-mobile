//
//  Genres.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 17/11/24.
//

enum Genre: Int, CaseIterable {
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case mystery = 9648
    case western = 37
    
    // Movie
    case adventure = 12
    case action = 28
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case romance = 10749
    case tvMovie = 10770
    case thriller = 53
    case war = 10752
    
    // TV Show
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

extension Genre {
    var displayName: String {
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
            return "Romance"
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
        case .tvMovie:
            return "Cinema TV"
        case .thriller:
            return "Thriller"
        case .war:
            return "Guerra"
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
