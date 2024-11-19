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
    var tvShowsByGenre: [TVShowGenre:[TVShow]] = [:]
    
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
    
    func getAllMediaByGenre(page: Int) async throws {
        if selectedMediaType == .movie {
            for genre in MovieGenre.allCases {
                try? await getMediaByGenre(genre: genre, page: 1)
            }
        }
        
        if selectedMediaType == .tv {
            for genre in TVShowGenre.allCases {
                try? await getMediaByGenre(genre: genre, page: 1)
            }
        }
    }
    
    func saveMovieToList(modelContext: ModelContext, movie: Movie) {
        modelContext.insert(movie)
        try? modelContext.save()
    }
    
    func saveTvShowToList(modelContext: ModelContext, tvShow: TVShow) {
        modelContext.insert(tvShow)
        try? modelContext.save()
    }
    
    // MARK: - Private Methods
    
    private func getMediaByGenre(genre: any Genre, page: Int) async throws {
        let result = try await networkService.getMediaByGenre(genre: genre, mediaType: selectedMediaType, page: page)
        
        if selectedMediaType == .movie,
           let movies = result as? [Movie],
           let movieGenre = genre as? MovieGenre {
            moviesByGenre[movieGenre] = movies
        }
        
        if selectedMediaType == .tv,
           let tvShows = result as? [TVShow],
           let tvShowGenre = genre as? TVShowGenre {
            tvShowsByGenre[tvShowGenre] = tvShows
        }
    }
}
