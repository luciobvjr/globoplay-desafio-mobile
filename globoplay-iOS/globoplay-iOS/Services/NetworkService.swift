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
}

struct NetworkService: NetworkServiceProtocol {
    private let functions = Functions.functions()
        
    func searchForMovies(searchTerm: String, page: Int) async throws -> [Movie] {
        let query = searchTerm + "&include_adult=false&language=pt-BR&page=\(page)"
        let response = try await functions.httpsCallable("searchForMovies").call(["query": query])
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: response.data) else {
            print("Error serializing response.data to JSON")
            return []
        }
        
        do {
            let movieResponse = try JSONDecoder().decode(SearchResponse<Movie>.self, from: jsonData)
            return movieResponse.results
        } catch {
            print("Error parsing JSON: \(error)")
            return []
        }
    }
    
    func searchForTVShows(searchTerm: String, page: Int) async throws -> [TVShow] {
        let query = searchTerm + "&include_adult=false&language=pt-BR&page=\(page)"
        let response = try await functions.httpsCallable("searchForTVShows").call(["query": query])
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: response.data) else {
            print("Error serializing response.data to JSON")
            return []
        }
        
        do {
            let movieResponse = try JSONDecoder().decode(SearchResponse<TVShow>.self, from: jsonData)
            return movieResponse.results
        } catch {
            print("Error parsing JSON: \(error)")
            return []
        }
    }
}
