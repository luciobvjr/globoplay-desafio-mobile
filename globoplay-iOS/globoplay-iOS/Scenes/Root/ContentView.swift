//
//  ContentView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 12/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingSplashScreen: Bool = true
    
    var body: some View {
        ZStack {
            splashScreen
                .opacity(isShowingSplashScreen ? 1 : 0)
            
            TabBarView()
                .opacity(isShowingSplashScreen ? 0 : 1)
        }
    }
    
    private var splashScreen: some View {
        Image("globoplay-logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 72)
            .background(Color.splashBackground)
            .task {
                try? await Task.sleep(for: .seconds(2))
                withAnimation(.linear(duration: 0.7)) {
                    isShowingSplashScreen = false
                }
            }
    }
}

#Preview {
    ContentView()
}
