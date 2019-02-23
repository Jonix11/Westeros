//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Jon Gonzalez on 31/01/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {
    
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!

    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "Leon RAmpante")
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", wikiURL: starkURL)
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", wikiURL: lannisterURL)
        
        robb = Person(name: "Robb", alias: "El joven lobo", house: starkHouse, image: UIImage())
        arya = Person(name: "Arya", house: starkHouse, image: UIImage())
        tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse, image: UIImage())
    }

    override func tearDown() {
        // Asignaríamos los objetos a nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Given - When - Then
    func testHouseExistence() {
        XCTAssertNotNil(starkHouse)
        
    }
    
    func testSigilExistence () {
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }
    
    func testHouseAddPerson() {
        XCTAssertEqual(starkHouse.count, 0)
        starkHouse.add(person: robb)
        
        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2)
    }
    
    func testHouseAddPersonsAtOnce() {
        starkHouse.add(persons: robb, arya, tyrion)
        XCTAssertEqual(starkHouse.count, 2)
    }
    
    func testHouseEquality() {
        // Identidad
        XCTAssertEqual(starkHouse, starkHouse)
        
        // Igualdad
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let jinxed = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", wikiURL: starkURL)
        XCTAssertEqual(starkHouse, jinxed)
        
        // Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }

    func testHouseHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseComparison() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
    
    // given-when-then
    func testHouse_SortedMembers_ReturnAnArrayOfSortedMembers() {
        XCTAssertEqual(lannisterHouse.sortedMembers, lannisterHouse.sortedMembers.sorted())
    }
}
