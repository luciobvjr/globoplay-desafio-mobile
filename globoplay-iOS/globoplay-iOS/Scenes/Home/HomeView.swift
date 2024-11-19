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
                
                CustomSegmentedPickerView(selectedMediaType: $homeViewModel.selectedMediaType)
                
                if homeViewModel.isSearching {
                    MediaGridView(medias: homeViewModel.selectedMediaType == .movie ?
                                  homeViewModel.searchedMovies : homeViewModel.searchedTvShows,
                                  selectedMediaType: homeViewModel.selectedMediaType)
                } else {
                    MediaByGenreView(homeViewModel: $homeViewModel)
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
