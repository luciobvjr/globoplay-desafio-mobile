//
//  MediaDetailsViewModel.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 19/11/24.
//

import SwiftUICore

@Observable
class MediaDetailsViewModel {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    var selectedMediaDetailsOption: MediaDetailsOption = .watchToo
    var recommendations: [Media] = []
    
    func getRecommendations(mediaId: Int, mediaType: MediaType) async {
        do {
            recommendations = try await networkService.getRecommendations(mediaId: mediaId, mediaType: mediaType, page: 1)
        } catch {
            print("Error getting recomendations: \(error)")
        }
    }
    
    func formatDate(dateString: String) -> String {
        let splitted = dateString.split(separator: "-")
        return [splitted[2], splitted[1], splitted[0]].joined(separator: "/")
    }
    
    func getGenresText(genreIds: [Int], mediaType: MediaType) -> String {
        var splitted: [String] = []
        
        for genre in MovieGenre.allCases where genreIds.contains(genre.rawValue) {
            splitted.append(genre.title)
        }
        
        for genre in TVShowGenre.allCases where genreIds.contains(genre.rawValue) {
            splitted.append(genre.title)
        }
     
        return splitted.joined(separator: ", ")
    }
}
