//
//  HomeView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 13/11/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @State private var homeViewModel: HomeViewModel = .init(networkService: NetworkService())
    
    var body: some View {
        ScrollView {
            VStack {
                searchBarView(prompt: "Pesquise por filmes ou séries")
                
                customSegmentedPickerView
                
                movieListView
                    .opacity(homeViewModel.selectedMediaType == .movie ? 1 : 0)

                tvShowListView
                    .opacity(homeViewModel.selectedMediaType == .movie ? 0 : 1)
            }
            .padding()
        }
        .background(Color.background)
        .onChange(of: homeViewModel.debouncedSearchTerm) { _, newValue in
            Task {
                try await homeViewModel.getMovies(page: 1)
                try await homeViewModel.getTvShows(page: 1)
            }
        }
        .task {
            for genre in MovieGenre.allCases {
                try? await homeViewModel.getMoviesByGenre(genre: genre, page: 1)
            }
        }
    }
    
    // MARK: - View components
    private var customSegmentedPickerView: some View {
        HStack {
            Group {
                segmentedPickerButton(mediaType: .movie)
                
                segmentedPickerButton(mediaType: .tv)
            }
            .frame(height: 80)
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func segmentedPickerButton(mediaType: MediaType) -> some View {
        let isSelected = homeViewModel.selectedMediaType == mediaType
        
        Button {
            withAnimation {
                homeViewModel.selectedMediaType = mediaType
            }
        } label: {
            VStack {
                Text(mediaType.displayName)
                
                Rectangle()
                    .frame(height: 2)
                    .opacity(isSelected ? 1 : 0)
            }
            .foregroundStyle(isSelected ? Color.white : Color.gray)
        }
    }
    
    private func searchBarView(prompt: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.white.opacity(0.2))
                .frame(height: 36)
            
            TextField("", text: $homeViewModel.searchTerm, prompt: Text(prompt))
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private var movieListView: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                ForEach(MovieGenre.allCases, id: \.rawValue) { genre in
                    genreSection(genre: genre)
                }
            }
        }
    }
    
    private func genreSection(genre: MovieGenre) -> some View {
        Section {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(homeViewModel.moviesByGenre[genre] ?? [], id: \.id) { movie in
                        movieCell(movie: movie)
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
    
    private func movieCell(movie: Movie) -> some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original" + movie.poster_path)) { image in
            image
                .resizable()
        } placeholder: {
            ZStack {
                Rectangle()
                    .foregroundStyle(Color.black.opacity(0.3))
                
                ProgressView()
            }
        }
        .frame(width: 92, height: 118)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.trailing, 8)
    }
    
    private var tvShowListView: some View {
        List {
            ForEach(TVShowGenre.allCases, id: \.rawValue) { genre in
                Section {
                    ForEach(homeViewModel.tvShows, id: \.id) { tvShow in
                        Text(tvShow.name)
                            .onTapGesture {
                                homeViewModel.saveTvShowToList(modelContext: modelContext, tvShow: tvShow)
                            }
                    }
                } header: {
                    Text(genre.title)
                }
            }
        }
    }
}

#Preview {
//    HomeView()
}
