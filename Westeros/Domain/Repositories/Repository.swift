//
//  Repository.swift
//  Westeros
//
//  Created by Jon Gonzalez on 06/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory() // Una variable estática es una variable de la clase
}

protocol HouseFactory {
    typealias houseFilter = (House) -> Bool
    var houses: [House] { get } // sólo get porque será de sólo lectura
    func house(named: String) -> House?
    func houses(filteredBy filter: houseFilter) -> [House]
}

protocol SeasonFactory {
    typealias seasonFilter = (Season) -> Bool
    var seasons: [Season] { get }
    func seasons(filteredBy filter: seasonFilter) -> [Season]
}

final class LocalFactory: HouseFactory, SeasonFactory {
    
    var houses: [House] {
        // Creación de casas
        let starkSigil = Sigil(image: UIImage(named:"codeIsComing")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister")!, description: "León Rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall")!, description: "Dragón tricéfalo")
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", wikiURL: starkURL)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", wikiURL: lannisterURL)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y sangre", wikiURL: targaryenURL)
        
        // Añadir algunos personajes
        let robb = Person(name: "Robb", alias: "El joven lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)
        
        starkHouse.add(persons: robb, arya)
        lannisterHouse.add(persons: tyrion, cersei, jaime)
        targaryenHouse.add(person: dani)
        
        
        return [targaryenHouse, starkHouse, lannisterHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        // let house = houses.filter { $0.name == name }.first
        let house = houses.first { $0.name.uppercased() == name.uppercased() } // con uppercased() "normalizamos los valores"
        return house
    }
    
    func houses(filteredBy theFilter: houseFilter) -> [House] {
        return houses.filter(theFilter)
    }
    
    // Conform to protocol 'SeasonFactory'
    
    var seasons: [Season] {
        // Seasons and episodes creation
        var dateStr = "17/04/2011"
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        var seasonDate = format.date(from: dateStr)!
        var episodeDate = format.date(from: dateStr)!
        
        
        let season1 = Season(name: "Season 1", releaseDate: seasonDate)
        let epidode1_1 = Episode(title: "Winter Is Coming", airDate: episodeDate, season: season1)
        dateStr = "24/04/2011"
        episodeDate = format.date(from: dateStr)!
        let episode2_1 = Episode(title: "The Kingsroad", airDate: episodeDate, season: season1)
        
        dateStr = "01/04/2012"
        seasonDate = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        let season2 = Season(name: "Season 2", releaseDate: seasonDate)
        let episode1_2 = Episode(title: "The North Remembers", airDate: episodeDate, season: season2)
        dateStr = "08/04/2012"
        episodeDate = format.date(from: dateStr)!
        let episode2_2 = Episode(title: "The Night Lands", airDate: episodeDate, season: season2)
        
        dateStr = "31/03/2013"
        seasonDate = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        let season3 = Season(name: "Season 3", releaseDate: seasonDate)
        let episode1_3 = Episode(title: "Valar Dohaeris", airDate: episodeDate, season: season3)
        dateStr = "07/04/2013"
        episodeDate = format.date(from: dateStr)!
        let episode2_3 = Episode(title: "Dark Wings, Dark Words", airDate: episodeDate, season: season3)
        
        dateStr = "06/04/2014"
        seasonDate = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        let season4 = Season(name: "Season 4", releaseDate: seasonDate)
        let episode1_4 = Episode(title: "Two Swords", airDate: episodeDate, season: season4)
        dateStr = "13/04/2014"
        episodeDate = format.date(from: dateStr)!
        let episode2_4 = Episode(title: "The Lion and the Rose", airDate: episodeDate, season: season4)
        
        dateStr = "12/04/2015"
        seasonDate = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        let season5 = Season(name: "Season 5", releaseDate: seasonDate)
        let episode1_5 = Episode(title: "The Wars To Come", airDate: episodeDate, season: season5)
        dateStr = "19/04/2015"
        episodeDate = format.date(from: dateStr)!
        let episode2_5 = Episode(title: "The House of Black and White", airDate: episodeDate, season: season5)
        
        dateStr = "24/04/2016"
        seasonDate = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        let season6 = Season(name: "Season 6", releaseDate: seasonDate)
        let episode1_6 = Episode(title: "The Red Woman", airDate: episodeDate, season: season6)
        dateStr = "01/05/2016"
        episodeDate = format.date(from: dateStr)!
        let episode2_6 = Episode(title: "Home", airDate: episodeDate, season: season6)
        
        dateStr = "16/07/2017"
        seasonDate = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        let season7 = Season(name: "Season 7", releaseDate: seasonDate)
        let episode1_7 = Episode(title: "Dragonstone", airDate: episodeDate, season: season7)
        dateStr = "23/07/2017"
        episodeDate = format.date(from: dateStr)!
        let episode2_7 = Episode(title: "Stormborn", airDate: episodeDate, season: season7)
        
        // add episodes to seasons
        season1.add(episodes: epidode1_1, episode2_1)
        season2.add(episodes: episode1_2, episode2_2)
        season3.add(episodes: episode1_3, episode2_3)
        season4.add(episodes: episode1_4, episode2_4)
        season5.add(episodes: episode1_5, episode2_5)
        season6.add(episodes: episode1_6, episode2_6)
        season7.add(episodes: episode1_7, episode2_7)
        
        return [season1, season2, season3, season4, season5, season6, season7].sorted()
    }
    
    func seasons(filteredBy filter: seasonFilter) -> [Season] {
        return seasons.filter(filter)
    }
}
