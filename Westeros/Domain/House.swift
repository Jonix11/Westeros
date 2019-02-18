//
//  House.swift
//  Westeros
//
//  Created by Jon Gonzalez on 31/01/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import Foundation


typealias Words = String
typealias Members = Set<Person>

final class House {
    // MARK: Properties
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _member: Members
    
    
    init(name: String, sigil: Sigil, words: Words, wikiURL: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = wikiURL
        _member = Members()
    }
}

extension House {
    var count: Int {
        return _member.count
    }
    
    var sortedMembers: [Person] {
        return _member.sorted()
    }
    
    func add(person: Person) {
        guard person.house == self else { return }
        _member.insert(person)
        
    }
    
    // Función variádica
    func add(persons: Person...) {
//        for person in persons {
//            add(person: person)
//        }
        persons.forEach { add(person: $0)}
    }
    
}

extension House {
    var proxyForEquality: String {
        return "\(name) \(words) \(count)"
    }
    
    var proxyForComparison: String {
        return name
    }
}

extension House: Equatable {
    static func == (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension House: Comparable {
    static func < (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
