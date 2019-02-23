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
    var splitViewController: UISplitViewController?
    var seasonDetailViewController: SeasonDetailViewController?
    var houseDetailViewController: HouseDetailViewController?
    var selected: String?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        
        // Crearno los modelos
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        let seasonListViewController = SeasonListViewController(model: seasons)
        let houseListViewController = HouseListViewController(model: houses)
        
        // Recuperar la última casa seleccionada (si es que la hay)
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        let lastSeasonSelected = seasonListViewController.lastSeasonSelected()
        seasonDetailViewController = SeasonDetailViewController(model: lastSeasonSelected)
        
        // Create UITabBarController
        let tabBarController = UITabBarController()
        // Create UITabBarItem
        let houseTabBarItem: UITabBarItem = UITabBarItem(title: "Houses", image: UIImage(), tag: 1)
        let seasonTabBarItem = UITabBarItem(title: "Seasons", image: UIImage(), tag: 2)
        // Assign TabBarItem to the controllers
        houseListViewController.tabBarItem = houseTabBarItem
        seasonListViewController.tabBarItem = seasonTabBarItem
        
        tabBarController.viewControllers = [houseListViewController.wrappedInNavigation(), seasonListViewController.wrappedInNavigation()]
        selected = "Houses"
        
        // Asignar delegados
        // Un objeto SOLO PUEDE TENER UN DELEGADO
        // Un objeto, puede ser delegado de muchos otros objetos
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        
        // Creamos el split view controller y asignamos los controladores
        splitViewController = UISplitViewController()
        //splitViewController.viewControllers = [houseListViewController.wrappedInNavigation(), houseDetailViewController.wrappedInNavigation()]
        
        tabBarController.delegate = self
        
        splitViewController?.preferredDisplayMode = .allVisible
        
        splitViewController?.viewControllers = [tabBarController, houseDetailViewController!.wrappedInNavigation()]
        
        
        // Asignamos el rootViewController del window
        window?.rootViewController = splitViewController
        
        
        
        // Para hacer uso de la collectionView
        // window?.rootViewController = HouseCollectionViewController(model: houses)
        
        return true
    }
}

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if selected == "Houses" {
            splitViewController?.showDetailViewController(seasonDetailViewController!.wrappedInNavigation(), sender: nil)
            selected = "Seasons"
        }
        else {
            splitViewController?.showDetailViewController(houseDetailViewController!.wrappedInNavigation(), sender: nil)
            selected = "Houses"
        }
        
    }
}
