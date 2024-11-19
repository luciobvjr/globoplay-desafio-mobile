//
//  MediaGridView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 19/11/24.
//

import SwiftUI

struct MediaGridView: View {
    let medias: [Media]
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(medias, id: \.id) { media in
                    NavigationLink {
                        MediaDetailsView(media: media)
                    } label: {
                        MediaCellView(media: media)
                    }
                }
            }
            .padding()
        }
    }
}

