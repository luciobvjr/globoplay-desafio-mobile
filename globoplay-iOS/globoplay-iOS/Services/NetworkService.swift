//
//  NetworkService.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 13/11/24.
//

import Foundation
import FirebaseFunctions
import FirebaseCore

protocol NetworkServiceProtocol {
    func searchForMovies(searchTerm: String, page: Int) async throws -> [Movie]
    func searchForTVShows(searchTerm: String, page: Int) async throws -> [TVShow]
    func getMediaByGenre(genre: any Genre, mediaType: MediaType, page: Int) async throws -> [Media]
}

struct NetworkService: NetworkServiceProtocol {
    private let functions = Functions.functions()
    
    func getMediaByGenre(genre: any Genre, mediaType: MediaType, page: Int) async throws -> [Media] {
        if mediaType == .movie, let movieGenre = genre as? MovieGenre {
            let response = try await functions.httpsCallable("getMediaByGenre").call(["genreId": movieGenre.rawValue,
                                                                                       "mediaType": mediaType.rawValue])
            let parsedResponse: SearchResponse<Movie>? = parseResponse(response: response)
            return parsedResponse?.results ?? []
        }
        
        if mediaType == .tv, let tvShowGenre = genre as? TVShowGenre {
            let response = try await functions.httpsCallable("getMediaByGenre").call(["genreId": tvShowGenre.rawValue,
                                                                                       "mediaType": mediaType.rawValue])
            let parsedResponse: SearchResponse<TVShow>? = parseResponse(response: response)
            return parsedResponse?.results ?? []
        }
        
        return []
    }
        
    func searchForMovies(searchTerm: String, page: Int) async throws -> [Movie] {
        let query = searchTerm + "&include_adult=false&language=pt-BR&page=\(page)"
        let response = try await functions.httpsCallable("searchForMovies").call(["query": query])
        
        let parsedResponse: SearchResponse<Movie>? = parseResponse(response: response)
        return parsedResponse?.results ?? []
    }
    
    func searchForTVShows(searchTerm: String, page: Int) async throws -> [TVShow] {
        let query = searchTerm + "&include_adult=false&language=pt-BR&page=\(page)"
        let response = try await functions.httpsCallable("searchForTVShows").call(["query": query])
        
        let parsedResponse: SearchResponse<TVShow>? = parseResponse(response: response)
        return parsedResponse?.results ?? []
    }
    
    // MARK: - Private Methods
    
    private func parseResponse<T: Media>(response: HTTPSCallableResult) -> SearchResponse<T>? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: response.data) else {
            print("Error serializing response.data to JSON")
            return nil
        }
        
        do {
            let mediaResponse = try JSONDecoder().decode(SearchResponse<T>.self, from: jsonData)
            return mediaResponse
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    }
}
