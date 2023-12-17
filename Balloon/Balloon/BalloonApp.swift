//
//  BalloonApp.swift
//  Balloon
//
//  Created by Юлия Гудошникова on 17.11.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck
import FirebaseAuth
import FirebaseFirestore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    let providerFactory = AppCheckDebugProviderFactory()
//    AppCheck.setAppCheckProviderFactory(providerFactory)
    FirebaseApp.configure()
    let settings = FirestoreSettings()
    settings.host = "localhost:8080"
    settings.isSSLEnabled = false // Установите значение false для использования HTTP вместо HTTPS
    let firestore = Firestore.firestore()
    firestore.settings = settings
    Auth.auth().useEmulator(withHost: "localhost", port: 9099)
    return true
  }
}

@main
struct BalloonApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
//            if UserDefaults.standard.string(forKey:"login") == "yes" {
//                HelloView()
//            } else {
               HomeTabBarView()
//            }
        }
    }
}
