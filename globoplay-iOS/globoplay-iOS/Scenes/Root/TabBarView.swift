//
//  TabBarView.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 13/11/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        if #available(iOS 18.0, *) {
            iOS18tabBarView
        } else {
            tabBarView
        }
    }
    
    @available(iOS 18.0, *)
    private var iOS18tabBarView: some View {
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
    
    private var tabBarView: some View {
        TabView {
            NavigationStack {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Tela de início")
                }
                .padding()
            }
            .tabItem {
                Label {
                    Text("Início")
                } icon: {
                    Image(systemName: "house")
                }
            }
            
            NavigationStack {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Minha lista")
                }
                .padding()
            }
            .tabItem {
                Label {
                    Text("Minha lista")
                } icon: {
                    Image(systemName: "star")
                }
            }
        }
    }
}

#Preview {
    TabBarView()
}
