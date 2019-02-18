//
//  Season.swift
//  Westeros
//
//  Created by Jon Gonzalez on 18/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import Foundation

typealias Episodes = Set<String>

final class Season {
    // MARK: Properties
    let name: String
    let releaseDate: Date
    private var _episodes: Episodes
    
    // MARK: Initialization
    init(name: String, releaseDate: Date) {
        self.name = name
        self.releaseDate = releaseDate
        _episodes = Episodes()
    }
}
