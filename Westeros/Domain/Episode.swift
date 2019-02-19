//
//  Episode.swift
//  Westeros
//
//  Created by Jon Gonzalez on 18/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import Foundation

final class Episode {
    // MARK: Properties
    let title: String
    let airDate: Date
    weak var season: Season?
    
    
    
    // MARK: Initialization
    init(title: String, airDate: Date, season: Season) {
        self.title = title
        self.airDate = airDate
        self.season = season
    }
}

extension Episode {
    var proxyForEquality: String {
        return "\(season?.name ?? "") \(title) \(airDate)"
    }
    
    var proxyForComparison: String {
        return "\(season?.name ?? "") \(title) \(airDate)"
    }
}

extension Episode: CustomStringConvertible {
    var description: String {
        return "\(title) \(airDate)"
    }
}

extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
    
}


