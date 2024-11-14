//
//  MyListView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 13/11/24.
//

import SwiftUI

struct MyListView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(Color.blue)
            
            Text("Minha lista")
        }
        .padding()
    }
}

#Preview {
    MyListView()
}
