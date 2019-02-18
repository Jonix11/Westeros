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

    override func setUp() {
       houses = Repository.local.houses
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

}
