//
//  MyListView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 13/11/24.
//

import SwiftUI
import SwiftData

struct MyListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var movies: [Movie]
    @Query var tvShows: [TVShow]
    @State private var myListViewModel: MyListViewModel = .init()
    
    var body: some View {
        ScrollView {
            VStack {
                searchBarView(prompt: "Pesquise por filmes ou séries")
                
                CustomSegmentedPickerView(selectedMediaType: $myListViewModel.selectedMediaType)
                
                if myListViewModel.selectedMediaType == .movie {
                    MediaGridView(medias: myListViewModel.filteredMovies,
                                  selectedMediaType: .movie)
                } else {
                    MediaGridView(medias: myListViewModel.filteredTvShows,
                                  selectedMediaType: .tv)
                }
            }
            .padding()
        }
        .background(Color.background)
        .task(id: movies) {
            myListViewModel.filteredMovies = movies
            myListViewModel.filteredTvShows = tvShows
        }
        .onChange(of: myListViewModel.searchTerm) { _, searchTerm in
            guard !searchTerm.isEmpty else {
                myListViewModel.filteredMovies = movies
                return
            }
            myListViewModel.search(searchTerm: searchTerm, movies: movies, tvShows: tvShows)
        }
    }
    
    // MARK: - View components
    
    private func searchBarView(prompt: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.white.opacity(0.2))
                .frame(height: 36)
            
            TextField("", text: $myListViewModel.searchTerm, prompt: Text(prompt))
                .padding(.horizontal)
        }
    }
}

#Preview {
    MyListView()
}
