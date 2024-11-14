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
    @State private var myListViewModel: MyListViewModel = .init()
    @Query var movies: [Movie]
    
    var body: some View {
        VStack {
            ForEach(movies, id: \.self) { movie in
                Text(movie.title)
                    .onTapGesture {
                        myListViewModel.removeMovieFromList(modelContext: modelContext, movie: movie)
                    }
            }
        }
        .padding()
    }
}

#Preview {
    MyListView()
}
