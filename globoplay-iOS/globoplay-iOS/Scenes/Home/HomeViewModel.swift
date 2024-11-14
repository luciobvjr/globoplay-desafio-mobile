//
//  HomeViewModel.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 13/11/24.
//

import SwiftUICore
import SwiftData

@Observable
class HomeViewModel {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    var movies: [Movie] = []
    var tvShows: [TVShow] = []
    var selectedMediaType: MediaType = .movie
    var debouncedSearchTerm: String = ""
    var searchTerm: String = "" {
        didSet {
            Task {
                try await Task.sleep(for: .seconds(2))
                debouncedSearchTerm = searchTerm
            }
        }
    }
    
    private var searchForMoviesTask: Task<Void, Error>?
    private var searchForTVShowsTask: Task<Void, Error>?
    
    func getMovies(page: Int) async throws {
        searchForMoviesTask?.cancel()
        
        searchForMoviesTask = Task {
            do {
                movies = try await networkService.searchForMovies(searchTerm: debouncedSearchTerm, page: page)
            } catch {
                print(error)
            }
        }
    }
    
    func getTvShows(page: Int) async throws {
        searchForTVShowsTask?.cancel()
        
        searchForTVShowsTask = Task {
            do {
                tvShows = try await networkService.searchForTVShows(searchTerm: debouncedSearchTerm, page: page)
            } catch {
                print(error)
            }
        }
    }
    
    func saveMovieToList(modelContext: ModelContext ,movie: Movie) {
        modelContext.insert(movie)
        try? modelContext.save()
    }
}
