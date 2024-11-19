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
}
