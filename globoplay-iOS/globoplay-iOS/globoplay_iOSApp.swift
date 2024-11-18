//
//  globoplay_iOSApp.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 12/11/24.
//

import SwiftUI
import SwiftData

@main
struct globoplay_iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Movie.self,
                                      TVShow.self])
        }
    }
}
