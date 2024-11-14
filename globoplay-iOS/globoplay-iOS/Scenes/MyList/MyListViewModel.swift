//
//  MyListViewModel.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 14/11/24.
//

import SwiftUICore
import SwiftData

@Observable
class MyListViewModel {
    func removeMovieFromList(modelContext: ModelContext, movie: Movie) {
        modelContext.delete(movie)
        try? modelContext.save()
    }
}
