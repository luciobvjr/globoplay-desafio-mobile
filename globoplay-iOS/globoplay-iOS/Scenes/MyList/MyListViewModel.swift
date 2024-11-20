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
        filteredTvShows = tvShows.filter({ $0.title.contains(searchTerm) })
    }
    
    func saveMediaToList(modelContext: ModelContext, media: Media, mediaType: MediaType) {
        if mediaType == .tv, let tvShow = media as? TVShow {
            modelContext.insert(tvShow)
        }
        
        if mediaType == .movie, let movie = media as? Movie {
            modelContext.insert(movie)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save after delete: \(error)")
        }
    }
    
    func removeMediaFromList(modelContext: ModelContext, media: Media, mediaType: MediaType) {
        let media = media
        if mediaType == .tv, let tvShow = media as? TVShow {
            modelContext.delete(tvShow)
        }
        
        if mediaType == .movie, let movie = media as? Movie {
            modelContext.delete(movie)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save after delete: \(error)")
        }
    }
}
