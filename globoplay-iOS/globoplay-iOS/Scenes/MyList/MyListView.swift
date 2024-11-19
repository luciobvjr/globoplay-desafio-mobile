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
                
                customSegmentedPickerView
                
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
        let isSelected = myListViewModel.selectedMediaType == mediaType
        
        Button {
            withAnimation {
                myListViewModel.selectedMediaType = mediaType
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
            
            TextField("", text: $myListViewModel.searchTerm, prompt: Text(prompt))
                .padding(.horizontal)
        }
    }
}

#Preview {
    MyListView()
}
