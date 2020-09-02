//
//  AppDelegate.swift
//  AmapDemo
//
//  Created by 温天浩 on 2020/8/20.
//  Copyright © 2020 CF. All rights reserved.
//

import UIKit
import AMapFoundationKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AMapServices.shared()?.apiKey = "d06ee358aa28e3f243cc664fe3383cc7"
        return true
    
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }

}

