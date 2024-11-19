//
//  MediaByGenreView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 18/11/24.
//

import SwiftUI

struct MediaByGenreView: View {
    @Binding var homeViewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                Group {
                    if homeViewModel.selectedMediaType == .movie {
                        ForEach(MovieGenre.allCases, id: \.rawValue) { genre in
                            genreSection(genre: genre)
                        }
                    } else {
                        ForEach(TVShowGenre.allCases, id: \.rawValue) { genre in
                            genreSection(genre: genre)
                        }
                    }
                }
            }
        }
    }
    
    private func genreSection(genre: any Genre) -> some View {
        Section {
            ScrollView(.horizontal) {
                LazyHStack {
                    if homeViewModel.selectedMediaType == .movie,
                       let movieGenre = genre as? MovieGenre {
                        ForEach(homeViewModel.moviesByGenre[movieGenre] ?? [], id: \.id) { movie in
                            NavigationLink {
                                MediaDetailsView(media: movie, selectedMediaType: .movie)
                            } label: {
                                MediaCellView(media: movie)
                            }
                        }
                    } else if homeViewModel.selectedMediaType == .tv,
                              let tvShowGenre = genre as? TVShowGenre {
                        ForEach(homeViewModel.tvShowsByGenre[tvShowGenre] ?? [], id: \.id) { tvShow in
                            NavigationLink {
                                MediaDetailsView(media: tvShow, selectedMediaType: .tv)
                            } label: {
                                MediaCellView(media: tvShow)
                            }
                        }
                    }
                }
                .frame(minHeight: 118)
            }
            .scrollIndicators(.hidden)
        } header: {
            Text(genre.title)
                .font(.title2)
                .fontWeight(.bold)
        }
    }
}
