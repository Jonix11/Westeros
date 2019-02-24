//
//  InitialSplitViewController.swift
//  Westeros
//
//  Created by Jon Gonzalez on 24/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

class InitialSplitViewController: UISplitViewController {

    // MARK: Properties
    let houseListViewController: HouseListViewController
    let seasonListViewController: SeasonListViewController
    let houseDetailViewController: HouseDetailViewController
    let seasonDetailViewController: SeasonDetailViewController
    
    // MARK: Initialization
    init(houses: [House], seasons: [Season]) {
        houseListViewController = HouseListViewController(model: houses)
        seasonListViewController = SeasonListViewController(model: seasons)
        
        // Recuperar la última casa seleccionada (si es que la hay)
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        // Recuperar la última season seleccionada
        let lastSeasonSelected = seasonListViewController.lastSeasonSelected()
        seasonDetailViewController = SeasonDetailViewController(model: lastSeasonSelected)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create UITabBarController
        let tabBarController = UITabBarController()
        // Create UITabBarItem
        let houseTabBarItem: UITabBarItem = UITabBarItem(title: "Houses", image: UIImage(), tag: 1)
        let seasonTabBarItem = UITabBarItem(title: "Seasons", image: UIImage(), tag: 2)
        // Assign TabBarItem to the controllers
        houseListViewController.tabBarItem = houseTabBarItem
        seasonListViewController.tabBarItem = seasonTabBarItem
        
        tabBarController.viewControllers = [houseListViewController.wrappedInNavigation(), seasonListViewController.wrappedInNavigation()]
        
        // Asignar delegados
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        tabBarController.delegate = self
        
        preferredDisplayMode = .allVisible
        viewControllers = [tabBarController, houseDetailViewController.wrappedInNavigation()]

    }
}

extension InitialSplitViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch tabBarController.selectedIndex {
            case 0:
                self.showDetailViewController(houseDetailViewController.wrappedInNavigation(), sender: self)
            default:
                self.showDetailViewController(seasonDetailViewController.wrappedInNavigation(), sender: self)
        }
    }
}
