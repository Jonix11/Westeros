//
//  UIViewController+Navigation.swift
//  Westeros
//
//  Created by Jon Gonzalez on 05/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
