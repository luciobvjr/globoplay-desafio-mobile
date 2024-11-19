//
//  MediaCellView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 18/11/24.
//

import SwiftUI

struct MediaCellView: View {
    let baseImageURL: String = "https://image.tmdb.org/t/p/w154"
    let media: Media
    
    var body: some View {        
        AsyncImage(url: URL(string: baseImageURL + (media.posterPath ?? ""))) { image in
            image
                .resizable()
        } placeholder: {
            ZStack {
                Rectangle()
                    .foregroundStyle(Color.black.opacity(0.3))
                
                ProgressView()
            }
        }
        .frame(width: 100, height: 126)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.trailing, 8)
    }
}

struct ControlledAsyncImage: View {
    let url: URL?
    let placeholder: () -> AnyView
    let content: (Image) -> AnyView

    @State private var uiImage: UIImage? = nil
    private static let cache = NSCache<NSURL, UIImage>()

    var body: some View {
        Group {
            if let uiImage = uiImage {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
                    .task {
                        await loadImage()
                    }
            }
        }
    }

    private func loadImage() async {
        guard let url = url else { return }

        if let cachedImage = ControlledAsyncImage.cache.object(forKey: url as NSURL) {
            uiImage = cachedImage
            return
        }

        do {
            try await withThrowingTaskGroup(of: UIImage?.self) { group in
                group.addTask {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    return UIImage(data: data)
                }

                for try await image in group {
                    if let image = image {
                        ControlledAsyncImage.cache.setObject(image, forKey: url as NSURL)
                        uiImage = image
                    }
                }
            }
        } catch {
            print("Erro ao carregar imagem:", error)
        }
    }
}
