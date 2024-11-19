//
//  MediaCellView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 18/11/24.
//

import SwiftUI

struct MediaCellView: View {
    let baseImageURL: String = "https://image.tmdb.org/t/p/w185"
    let media: Media
    
    var size: CGSize? = .init(width: 106, height: 160)
    
    var body: some View {
        Group {
            if let posterPath = media.posterPath, !posterPath.isEmpty {
                AsyncImage(url: URL(string: baseImageURL + posterPath)) { image in
                    image
                        .resizable()
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .foregroundStyle(Color.black.opacity(0.3))
                        
                        ProgressView()
                    }
                }
            } else {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color.black.opacity(0.3))
                    
                    Text(media.title)
                        .font(.caption)
                        .padding(.horizontal, 4)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .frame(width: size?.width, height: size?.height)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
