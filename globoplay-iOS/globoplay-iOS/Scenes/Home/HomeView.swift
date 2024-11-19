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
                
                if homeViewModel.isSearching {
                    MediaGridView(medias: homeViewModel.selectedMediaType == .movie ?
                                  homeViewModel.searchedMovies : homeViewModel.searchedTvShows)
                } else {
                    mediaByGenreView
                }
            }
            .padding()
        }
        .background(Color.background)
        .task(id: homeViewModel.debouncedSearchTerm) {
            try? await homeViewModel.getMovies(page: 1)
            try? await homeViewModel.getTvShows(page: 1)
        }
        .task(id: homeViewModel.selectedMediaType) {
            try? await homeViewModel.getAllMediaByGenre(page: 1)
        }
    }
    
    private var mediaByGenreView: some View {
        if homeViewModel.selectedMediaType == .movie {
            MediaByGenreView(homeViewModel: $homeViewModel)
        } else {
            MediaByGenreView(homeViewModel: $homeViewModel)
        }
    }
    
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
}

#Preview {
    //    HomeView()
}

struct MediaGridView: View {
    let medias: [Media]
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(medias, id: \.id) { media in
                    MediaCellView(media: media)
                }
            }
            .padding()
        }
    }
}
