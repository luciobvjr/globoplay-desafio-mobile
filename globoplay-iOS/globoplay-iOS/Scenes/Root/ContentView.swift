//
//  ContentView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 12/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingSplashScreen: Bool = false
    
    var body: some View {
        if isShowingSplashScreen {
            splashScreen
        } else {
            contentView
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
    
    private var contentView: some View {
        TabView {
            Tab {
                NavigationStack {
                    VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Tela de início")
                    }
                    .padding()
                }
            } label: {
                Label {
                    Text("Início")
                } icon: {
                    Image(systemName: "house")
                }
            }
            
            Tab {
                NavigationStack {
                    VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Minha lista")
                    }
                    .padding()
                }
            } label: {
                Label {
                    Text("Minha lista")
                } icon: {
                    Image(systemName: "star")
                }
            }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .black
        }
    }
}

#Preview {
    ContentView()
}
