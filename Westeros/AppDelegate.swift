//
//  AppDelegate.swift
//  Westeros
//
//  Created by Jon Gonzalez on 31/01/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        // Crearno los modelos
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        let initialSplitViewController = InitialSplitViewController(houses: houses, seasons: seasons)
        // Asignamos el rootViewController del window
        window?.rootViewController = initialSplitViewController
        
        return true
    }
}
