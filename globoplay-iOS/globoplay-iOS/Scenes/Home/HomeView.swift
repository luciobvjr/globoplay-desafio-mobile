//
//  HomeView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 13/11/24.
//

import SwiftUI

struct HomeView: View {
    @State private var homeViewModel: HomeViewModel = .init(networkService: NetworkService())
    
    var body: some View {
        ScrollView {
            VStack {
                searchBarView(prompt: "Pesquise por filmes ou séries")
                
                customSegmentedPickerView
                
                if homeViewModel.selectedMediaType == .movie {
                    movieListView
                } else {
                    tvShowListView
                }
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
    
    private var movieListView: some View {
        ForEach(homeViewModel.movies, id: \.id) { movie in
            Text(movie.title)
        }
    }
    
    private var tvShowListView: some View {
        ForEach(homeViewModel.tvShows, id: \.id) { tvShow in
            Text(tvShow.name)
        }
    }
}

#Preview {
    HomeView()
}
