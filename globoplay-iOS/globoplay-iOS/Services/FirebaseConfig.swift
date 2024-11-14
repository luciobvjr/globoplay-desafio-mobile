//
//  FirebaseConfig.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 14/11/24.
//

import FirebaseCore
import FirebaseAppCheck
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
            let providerFactory = AppCheckDebugProviderFactory()
            AppCheck.setAppCheckProviderFactory(providerFactory)
            
            FirebaseApp.configure()
        }
        
        return true
        
    }
}
