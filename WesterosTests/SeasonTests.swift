//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Jon Gonzalez on 18/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {
    var season1: Season!
    var season2: Season!
    var date1: Date!
    var date2: Date!

    override func setUp() {
        var dateStr = "17/04/2011"
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        date1 = format.date(from: dateStr)!
        dateStr = "01/04/2012"
        date2 = format.date(from: dateStr)
        season1 = Season(name: "Season 1", releaseDate: date1)
        season2 = Season(name: "Season 2", releaseDate: date2)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil(season1)
    }
    
    func testSeasonHasDescription () {
        XCTAssertNotNil(season1.description)
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testSeasonEquality() {
        // Identity
        XCTAssertEqual(season1, season1)
        
        // Equality
        let season = Season(name: "Season 1", releaseDate: date1)
        XCTAssertEqual(season1, season)
        
        // Inequality
        XCTAssertNotEqual(season1, season2)
    }
    
    func testSeasonComparison() {
        XCTAssertLessThan(season1, season2)
    }

}
