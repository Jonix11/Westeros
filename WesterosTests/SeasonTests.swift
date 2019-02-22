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
    var episode1_1: Episode!
    var episode2_1: Episode!
    var episode1_2: Episode!
    var season1Date: Date!
    var episodeDate: Date!
    var season2Date: Date!

    override func setUp() {
        var dateStr = "17/04/2011"
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        season1Date = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        
        season1 = Season(name: "Season 1", releaseDate: season1Date, image: UIImage())
        episode1_1 = Episode(title: "Winter Is Coming", airDate: episodeDate, summary: "Lord Stark is troubled by reports from a Night's Watch deserter; King Robert and the Lannisters arrive at Winterfell; Viserys Targaryen forges a new alliance.",season: season1)
        
        dateStr = "24/04/2011"
        episodeDate = format.date(from: dateStr)!
        episode2_1 = Episode(title: "The Kingsroad", airDate: episodeDate, summary: "The Lannisters plot to ensure Bran's silence; Jon and Tyrion head to the Wall; Ned faces a family crisis en route to King's Landing.", season: season1)
        
        dateStr = "01/04/2012"
        season2Date = format.date(from: dateStr)
        episodeDate = format.date(from: dateStr)
        season2 = Season(name: "Season 2", releaseDate: season2Date, image: UIImage())
        episode1_2 = Episode(title: "The North Remembers", airDate: episodeDate, summary: "Tyrion arrives to save Joffrey's crown; Daenerys searches for allies and water in the Red Waste; Jon Snow faces the wilderness beyond the Wall.", season: season2)
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
    
    func testSeasonAddEpisode() {
        XCTAssertEqual(season1.count, 0)
        
        season1.add(episode: episode1_1)
        XCTAssertEqual(season1.count, 1)
        
        season1.add(episode: episode2_1)
        XCTAssertEqual(season1.count, 2)
        
        season1.add(episode: episode1_2)
        XCTAssertEqual(season1.count, 2)
    }
    
    func testSeasonAddEpisodesAtOnce() {
        season1.add(episodes: episode1_1, episode2_1, episode1_2)
        XCTAssertEqual(season1.count, 2)
    }
    
    func testSeasonEpisodesSorted() {
        season1.add(episodes: episode1_1, episode2_1)
        XCTAssertEqual(season1.episodesSorted, season1.episodesSorted.sorted())
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testSeasonEquality() {
        // Identity
        XCTAssertEqual(season1, season1)
        
        // Equality
        let season = Season(name: "Season 1", releaseDate: season1Date, image: UIImage())
        XCTAssertEqual(season1, season)
        
        // Inequality
        XCTAssertNotEqual(season1, season2)
    }
    
    func testSeasonComparison() {
        XCTAssertLessThan(season1, season2)
    }

}
