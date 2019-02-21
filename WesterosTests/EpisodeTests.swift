//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Jon Gonzalez on 18/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    
    var season1: Season!
    var episode1_1: Episode!
    var episode2_1: Episode!
    var date1: Date!
    var date2: Date!

    override func setUp() {
        var dateStr = "17/04/2011"
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        date1 = format.date(from: dateStr)!
        season1 = Season(name: "Season 1", releaseDate: date1)
        episode1_1 = Episode(title: "Winter Is Coming", airDate: date1, season: season1)
        dateStr = "24/04/2011"
        date2 = format.date(from: dateStr)
        episode2_1 = Episode(title: "The Kingsroad", airDate: date2, season: season1)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEpisodeExistence() {
        XCTAssertNotNil(episode1_1)
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil(season1)
    }
    
    func testEpisodeHasDescription () {
        XCTAssertNotNil(episode1_1.description)
    }
    
    func testEpisodeHashable() {
        XCTAssertNotNil(episode1_1.hashValue)
    }
    
    func testEpisodeEquality() {
        // Identity
        XCTAssertEqual(episode1_1, episode1_1)
        
        // Equality
        let episode1 = Episode(title: "Winter Is Coming", airDate: date1, season: season1)
        XCTAssertEqual(episode1, episode1_1)
        
        // Inequality
        XCTAssertNotEqual(episode2_1, episode1_1)
    }
    
    func testEpisodeComparison() {
        XCTAssertLessThan(episode1_1, episode2_1)
    }

}
