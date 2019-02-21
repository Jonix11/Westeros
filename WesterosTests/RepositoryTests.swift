//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Jon Gonzalez on 06/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import XCTest
@testable import Westeros


class RepositoryTests: XCTestCase {
    
    var houses: [House]!
    var seasons: [Season]!

    override func setUp() {
        houses = Repository.local.houses
        seasons = Repository.local.seasons
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryHouseExistence() {
        XCTAssertNotNil(houses)
    }
    
    func testLocalRepository_HouseCount() {
        XCTAssertEqual(houses.count, 3)
    }
    
    func testLocalRepository_ReturnSortedArrayOfHouses() {
        XCTAssertEqual(houses, houses.sorted())
    }
    
    func testLocalRepositoryReturnHousesByNameCaseInsensitively() {
        let stark = Repository.local.house(named: "stArk")
        XCTAssertNotNil(stark)
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    // given - when - then
    func testLocalRepository_HousesFilteredBy_ReturnsTheCorrectValue() {
        // let filtered = Repository.local.houses { $0.count == 1 }
        
        let filtered = Repository.local.houses(filteredBy:{ $0.count == 1 })
        XCTAssertEqual(filtered.count, 1)
    }
    
    func testLocalRepositorySeasonExistence() {
        XCTAssertNotNil(seasons)
    }
    
    func testLocalRepository_SeasonCount() {
        XCTAssertEqual(seasons.count, 7)
    }
    
    func testLocalRepository_ReturnSortedArrayOfSeasons() {
        XCTAssertEqual(seasons, seasons.sorted())
    }
    
    func testLocalRepository_SeasonsFilteredBy_ReturnTheCorrectValue() {
        var filtered = Repository.local.seasons(filteredBy: {$0.count == 2 })
        XCTAssertEqual(filtered.count, 7)
        
        let dateStr = "01/01/2014"
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        let filterDate = format.date(from: dateStr)!
        filtered = Repository.local.seasons(filteredBy: { $0.releaseDate > filterDate })
        XCTAssertEqual(filtered.count, 4)
    }

}
