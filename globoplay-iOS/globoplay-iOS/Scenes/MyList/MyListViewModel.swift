//
//  MyListViewModel.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 14/11/24.
//

import SwiftUICore
import SwiftData

@Observable
class MyListViewModel {
    var filteredMovies: [Movie] = []
    var filteredTvShows: [TVShow] = []
    var selectedMediaType: MediaType = .movie
    var searchTerm: String = ""
    
    func search(searchTerm: String, movies: [Movie], tvShows: [TVShow]) {
        filteredMovies = movies.filter({ $0.title.contains(searchTerm) })
        filteredTvShows = tvShows.filter({ $0.name.contains(searchTerm) })
    }
    
    func removeMovieFromList(modelContext: ModelContext, movie: Movie) {
        modelContext.delete(movie)
        try? modelContext.save()
    }
    
    func removeTvShowFromList(modelContext: ModelContext, tvShow: TVShow) {
        modelContext.delete(tvShow)
        try? modelContext.save()
    }
}
