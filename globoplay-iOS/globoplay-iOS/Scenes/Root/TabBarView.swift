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
                        header
                        HomeView()
                    }
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
                        header
                        MyListView()
                    }
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
                    header
                    HomeView()
                }
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
                    header
                    MyListView()
                }
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
    
    private var header: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.black)
                .frame(height: 70)
            
            Image("globoplay-logo")
                .resizable()
                .frame(width: 182, height: 40)
        }
    }
}

#Preview {
    TabBarView()
}
