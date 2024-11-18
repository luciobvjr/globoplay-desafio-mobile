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
    var moviesByGenre: [MovieGenre:[Movie]] = [:]
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
    private var getMoviesByGenreTask: Task<Void, Error>?
    
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
    
    func getMoviesByGenre(genre: MovieGenre, page: Int) async throws {
        let result = try await networkService.getMoviesByGenre(genre: genre, page: page)
        moviesByGenre[genre] = result
    }
    
    func saveMovieToList(modelContext: ModelContext, movie: Movie) {
        modelContext.insert(movie)
        try? modelContext.save()
    }
    
    func saveTvShowToList(modelContext: ModelContext, tvShow: TVShow) {
        modelContext.insert(tvShow)
        try? modelContext.save()
    }
}
