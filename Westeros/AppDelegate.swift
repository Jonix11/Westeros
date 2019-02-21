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
        window?.backgroundColor = .red
        
        // Crearno los modelos
        let houses = Repository.local.houses
        
        let seasons = Repository.local.seasons
        
        let seasonListViewController = SeasonListViewController(model: seasons)
        
        
        // Crear el combinador
        //let tabBarController = UITabBarController()
        //tabBarController.viewControllers = houses.map { HouseDetailViewController(model: $0).wrappedInNavigation()}
        
        // Creamos los controladores (el que irá en master, y el que irá en el detail) de la tabla
        let houseListViewController = HouseListViewController(model: houses)
        // Recuperar la última casa seleccionada (si es que la hay)
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        
        let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        // Asignar delegados
        // Un objeto SOLO PUEDE TENER UN DELEGADO
        // Un objeto, puede ser delegado de muchos otros objetos
        houseListViewController.delegate = houseDetailViewController
        
        // Creamos el split view controller y asignamos los controladores
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [houseListViewController.wrappedInNavigation(), houseDetailViewController.wrappedInNavigation()]
        
        
        
        // Asignamos el rootViewController del window
        //-------window?.rootViewController = splitViewController
        
        window?.rootViewController = seasonListViewController.wrappedInNavigation()
        
        // Para hacer uso de la collectionView
        // window?.rootViewController = HouseCollectionViewController(model: houses)
        
        return true
    }


}

