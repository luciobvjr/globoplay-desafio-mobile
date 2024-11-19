//
//  MediaGridView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 19/11/24.
//

import SwiftUI

struct MediaGridView: View {
    let medias: [Media]
    let selectedMediaType: MediaType
    let columns = [GridItem(.flexible(), spacing: 16),
                   GridItem(.flexible(), spacing: 16),
                   GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(medias, id: \.id) { media in
                    NavigationLink {
                        MediaDetailsView(media: media, selectedMediaType: selectedMediaType)
                    } label: {
                        MediaCellView(media: media)
                    }
                }
            }
            .padding()
        }
    }
}

