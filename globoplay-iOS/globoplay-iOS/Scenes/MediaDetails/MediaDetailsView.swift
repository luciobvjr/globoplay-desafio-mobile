//
//  MediaDetailsView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 19/11/24.
//

import SwiftUI
import SwiftData

struct MediaDetailsView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var mediaDetailsViewModel: MediaDetailsViewModel = .init(networkService: NetworkService())
    @State private var myListViewModel: MyListViewModel = .init()
    
    @Query var movies: [Movie]
    @Query var tvShows: [TVShow]
    let baseImageURL: String = "https://image.tmdb.org/t/p/w154"
    
    let media: Media
    let selectedMediaType: MediaType
    
    var queryMedia: Media? {
        let medias: [Media] = movies + tvShows
        return medias.first(where: { $0.id == media.id })
    }
    
    var overView: String {
        guard !media.overview.isEmpty else { return "Descrição indisponível" }
        return media.overview
    }
    
    var myListButtonTitle: String {
        guard queryMedia != nil else {
           return "Minha Lista"
        }
        
        return "Adicionado"
    }
    
    var myListButtonImageName: String {
        guard queryMedia != nil else {
           return "star.fill"
        }
        
        return "checkmark"
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                header
                
                Text(overView)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 8)
                
                myListButton
                
                CustomSegmentedPickerView(selectedMediaType: .constant(.none),
                                          selectedMediaDetailsOption: $mediaDetailsViewModel.selectedMediaDetailsOption)
                
                Group {
                    if mediaDetailsViewModel.selectedMediaDetailsOption == .watchToo {
                        MediaGridView(medias: mediaDetailsViewModel.recommendations, selectedMediaType: selectedMediaType)
                    }
                    
                    if mediaDetailsViewModel.selectedMediaDetailsOption == .details {
                        detailsView
                    }
                }
                .background(Color.background)
            }
        }
        .task {
            await mediaDetailsViewModel.getRecommendations(mediaId: media.id, mediaType: selectedMediaType)
        }
    }
    
    var header: some View {
        ZStack {
            MediaCellView(media: media, size: nil)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .blur(radius: 10)
                .overlay(
                    LinearGradient(colors: [.black, .black.opacity(0)],
                                   startPoint: .bottom,
                                   endPoint: .top)
                    .offset(y: 12)
                )
            
            VStack(alignment: .center, spacing: 16) {
                MediaCellView(media: media)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Text(media.title)
                    .font(.title)
                
                if let genreId = media.genreIds.first {
                    if MovieGenre.allCases.contains(where: { $0.rawValue == genreId }) {
                        Text(MovieGenre(rawValue: genreId)?.title ?? "")
                            .opacity(0.5)
                    } else if TVShowGenre.allCases.contains(where: { $0.rawValue == genreId }) {
                        Text(TVShowGenre(rawValue: genreId)?.title ?? "")
                            .opacity(0.5)
                    }
                }
            }
        }
    }
    
    var myListButton: some View {
        Button {
            if let queryMedia {
                myListViewModel.removeMediaFromList(modelContext: modelContext,
                                                    media: queryMedia,
                                                    mediaType: selectedMediaType)
            } else {
                myListViewModel.saveMediaToList(modelContext: modelContext,
                                                media: media,
                                                mediaType: selectedMediaType)
            }
        } label: {
            HStack {
                Image(systemName: myListButtonImageName)
                
                Text(myListButtonTitle)
            }
            .font(.title3)
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 8).stroke())
        }
    }
    
    @ViewBuilder
    var detailsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let originalTitle = media.originalTitle {
                Text("Título original: \(originalTitle)")
            }
            
            Text("Gêneros: \(mediaDetailsViewModel.getGenresText(genreIds: media.genreIds, mediaType: selectedMediaType))")
            
            if let releaseDate = media.releaseDate {
                Text("Data de lançamento: \(mediaDetailsViewModel.formatDate(dateString: releaseDate))")
            }
            
            if let voteAverage = media.voteAverage {
                Text("Nota Média: \(voteAverage.formatted())")
            }
            
            if let voteCount = media.voteCount {
                Text("Total de Votos: \(voteCount)")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
        .padding(.vertical, 16)
    }
}
