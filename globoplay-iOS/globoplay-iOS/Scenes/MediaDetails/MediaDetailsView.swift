//
//  MediaDetailsView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 19/11/24.
//

import SwiftUI

struct MediaDetailsView: View {
    let baseImageURL: String = "https://image.tmdb.org/t/p/w154"
    let media: Media
    
    var overView: String {
        guard let overview = media.overview, !overview.isEmpty else { return "Descrição indisponível" }
        return overview
    }
    
    var body: some View {
        ScrollView {
            VStack {
                header
                
                Text(overView)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 16)
                    .padding(.horizontal, 8)
                
                
            }
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
}

