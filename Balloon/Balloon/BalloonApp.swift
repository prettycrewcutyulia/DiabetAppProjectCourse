//
//  BalloonApp.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 17.11.2023.
//

import SwiftUI

@main
struct BalloonApp: App {
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.string(forKey:"login") == "yes" {
                HomeTabBarView()
            } else {
                AuthorizationView()
            }
        }
    }
}
