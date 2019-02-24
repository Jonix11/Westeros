//
//  Repository.swift
//  Westeros
//
//  Created by Jon Gonzalez on 06/02/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

enum Houses: String {
    case stark = "Stark"
    case lannister = "Lannister"
    case targaryen = "Targaryen"
}

final class Repository {
    static let local = LocalFactory() // Una variable estática es una variable de la clase
}

protocol HouseFactory {
    typealias houseFilter = (House) -> Bool
    var houses: [House] { get } // sólo get porque será de sólo lectura
    func house(named: String) -> House?
    func house(named: Houses) -> House?
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
        let robb = Person(name: "Robb", alias: "El joven lobo", house: starkHouse, image: UIImage(named: "RobbStark")!)
        let arya = Person(name: "Arya", house: starkHouse, image: UIImage(named: "AryaStark")!)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse, image: UIImage(named: "TyrionLannister")!)
        let cersei = Person(name: "Cersei", house: lannisterHouse, image: UIImage(named: "CerceiLannister")!)
        let jaime = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse, image: UIImage(named: "JaimeLannister")!)
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse, image: UIImage(named: "DaenerysTargaryen")!)
        
        
        return [targaryenHouse, starkHouse, lannisterHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        // let house = houses.filter { $0.name == name }.first
        let house = houses.first { $0.name.uppercased() == name.uppercased() } // con uppercased() "normalizamos los valores"
        return house
    }
    
    func house(named name: Houses) -> House? {
        let house = houses.first { $0.name.uppercased() == name.rawValue.uppercased() }
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
        
        
        let season1 = Season(name: "Season 1", releaseDate: seasonDate, image: UIImage(named: "Season1")!)
        let episode1_1 = Episode(title: "Winter Is Coming", airDate: episodeDate, summary: "Lord Stark is troubled by reports from a Night's Watch deserter; King Robert and the Lannisters arrive at Winterfell; Viserys Targaryen forges a new alliance.",season: season1)
        dateStr = "24/04/2011"
        episodeDate = format.date(from: dateStr)!
        let episode2_1 = Episode(title: "The Kingsroad", airDate: episodeDate, summary: "The Lannisters plot to ensure Bran's silence; Jon and Tyrion head to the Wall; Ned faces a family crisis en route to King's Landing.",season: season1)
        dateStr = "01/05/2011"
        episodeDate = format.date(from: dateStr)!
        let episode3_1 = Episode(title: "Lord Snow", airDate: episodeDate, summary: "Jon impresses Tyrion at Castle Black; Ned confronts his past and future at King's Landing; Daenerys finds herself at odds with Viserys.",season: season1)
        dateStr = "08/05/2011"
        episodeDate = format.date(from: dateStr)!
        let episode4_1 = Episode(title: "Cripples, Bastards, and Broken Things", airDate: episodeDate, summary: "Ned probes Arryn's death; Jon takes measures to protect Sam; Tyrion is caught in the wrong place.",season: season1)
        
        dateStr = "01/04/2012"
        seasonDate = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        let season2 = Season(name: "Season 2", releaseDate: seasonDate, image: UIImage(named: "Season2")!)
        let episode1_2 = Episode(title: "The North Remembers", airDate: episodeDate, summary: "Tyrion arrives to save Joffrey's crown; Daenerys searches for allies and water in the Red Waste; Jon Snow faces the wilderness beyond the Wall.", season: season2)
        dateStr = "08/04/2012"
        episodeDate = format.date(from: dateStr)!
        let episode2_2 = Episode(title: "The Night Lands", airDate: episodeDate, summary: "Arya shares a secret; a scout returns to Dany with disturbing news; Theon comes home to the Iron Islands; Tyrion administers justice; Jon witnesses a terrible crime.", season: season2)
        dateStr = "15/04/2012"
        episodeDate = format.date(from: dateStr)!
        let episode3_2 = Episode(title: "What Is Dead May Never Die", airDate: episodeDate, summary: "Tyrion roots out a spy; Catelyn meets a new king and queen; Bran dreams; Theon drowns.", season: season2)
        dateStr = "22/04/2012"
        episodeDate = format.date(from: dateStr)!
        let episode4_2 = Episode(title: "Garden of Bones", airDate: episodeDate, summary: "Catelyn tries to save two kings from themselves; Tyrion practices coercion; Robb meets a foreigner; Dany finds her ally; Melisandre casts a shadow on the Stormlands.", season: season2)
        
        dateStr = "31/03/2013"
        seasonDate = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        let season3 = Season(name: "Season 3", releaseDate: seasonDate, image: UIImage(named: "Season3")!)
        let episode1_3 = Episode(title: "Valar Dohaeris", airDate: episodeDate, summary: "Jon is tested by the wildling king; Tyrion asks for his reward; Daenerys sails into Slaver's Bay.", season: season3)
        dateStr = "07/04/2013"
        episodeDate = format.date(from: dateStr)!
        let episode2_3 = Episode(title: "Dark Wings, Dark Words", airDate: episodeDate, summary: "Arya runs into the Brotherhood Without Banners; Jaime finds a way to pass the time.", season: season3)
        dateStr = "14/04/2013"
        episodeDate = format.date(from: dateStr)!
        let episode3_3 = Episode(title: "Walk of Punishment", airDate: episodeDate, summary: "Dany hears the price; Jaime strikes a deal with his captors.", season: season3)
        dateStr = "21/04/2013"
        episodeDate = format.date(from: dateStr)!
        let episode4_3 = Episode(title: "And Now His Watch Is Ended", airDate: episodeDate, summary: "The Night's Watch takes stock; Dany exchanges a chain for a whip.", season: season3)
        
        dateStr = "06/04/2014"
        seasonDate = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        let season4 = Season(name: "Season 4", releaseDate: seasonDate, image: UIImage(named: "Season4")!)
        let episode1_4 = Episode(title: "Two Swords", airDate: episodeDate, summary: "King's Landing prepares for a royal wedding; Dany finds the way to Meereen; the Night's Watch braces for a new threat.", season: season4)
        dateStr = "13/04/2014"
        episodeDate = format.date(from: dateStr)!
        let episode2_4 = Episode(title: "The Lion and the Rose", airDate: episodeDate, summary: "The Lannisters and their guests gather in King's Landing.", season: season4)
        dateStr = "20/04/2014"
        episodeDate = format.date(from: dateStr)!
        let episode3_4 = Episode(title: "Breaker of Chains", airDate: episodeDate, summary: "Tyrion ponders his options; Tywin extends an olive branch; Jon proposes a bold plan.", season: season4)
        dateStr = "27/04/2014"
        episodeDate = format.date(from: dateStr)!
        let episode4_4 = Episode(title: "Oathkeeper", airDate: episodeDate, summary: "Dany balances justice and mercy; Jaime turns to Brienne; Jon readies his men.", season: season4)
        
        dateStr = "12/04/2015"
        seasonDate = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        let season5 = Season(name: "Season 5", releaseDate: seasonDate, image: UIImage(named: "Season5")!)
        let episode1_5 = Episode(title: "The Wars To Come", airDate: episodeDate, summary: "Tyrion learns of a conspiracy; Jon is caught between two kings.", season: season5)
        dateStr = "19/04/2015"
        episodeDate = format.date(from: dateStr)!
        let episode2_5 = Episode(title: "The House of Black and White", airDate: episodeDate, summary: "Arya arrives in Braavos; Stannis tempts Jon.", season: season5)
        dateStr = "26/04/2015"
        episodeDate = format.date(from: dateStr)!
        let episode3_5 = Episode(title: "High Sparrow", airDate: episodeDate, summary: "Cersei does justice; Tyrion walks the Long Bridge of Volantis.", season: season5)
        dateStr = "03/05/2015"
        episodeDate = format.date(from: dateStr)!
        let episode4_5 = Episode(title: "Sons of the Harpy", airDate: episodeDate, summary: "The Faith Militant grow increasingly aggressive; Jaime and Bronn head south; Ellaria and the Sand Snakes vow vengeance.", season: season5)
        
        dateStr = "24/04/2016"
        seasonDate = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        let season6 = Season(name: "Season 6", releaseDate: seasonDate, image: UIImage(named: "Season6")!)
        let episode1_6 = Episode(title: "The Red Woman", airDate: episodeDate, summary: "Jon Snow is dead; Daenerys meets a strong man; Cersei sees her daughter again.", season: season6)
        dateStr = "01/05/2016"
        episodeDate = format.date(from: dateStr)!
        let episode2_6 = Episode(title: "Home", airDate: episodeDate, summary: "Bran goes home; The Night's Watch stands behind Thorne.", season: season6)
        dateStr = "08/05/2016"
        episodeDate = format.date(from: dateStr)!
        let episode3_6 = Episode(title: "Oathbreaker", airDate: episodeDate, summary: "Daenerys meets her future; Arya trains to be No One.", season: season6)
        dateStr = "15/05/2016"
        episodeDate = format.date(from: dateStr)!
        let episode4_6 = Episode(title: "Book of the Stranger", airDate: episodeDate, summary: "Tyrion strikes a deal; Jorah and Daario undertake a difficult task.", season: season6)
        
        dateStr = "16/07/2017"
        seasonDate = format.date(from: dateStr)!
        episodeDate = format.date(from: dateStr)!
        let season7 = Season(name: "Season 7", releaseDate: seasonDate, image: UIImage(named: "Season7")!)
        let episode1_7 = Episode(title: "Dragonstone", airDate: episodeDate, summary: "Jon organizes the defense of the North. Cersei tries to even the odds. Daenerys comes home.", season: season7)
        dateStr = "23/07/2017"
        episodeDate = format.date(from: dateStr)!
        let episode2_7 = Episode(title: "Stormborn", airDate: episodeDate, summary: "Daenerys receives an unexpected visitor; Jon faces a revolt.", season: season7)
        dateStr = "30/07/2017"
        episodeDate = format.date(from: dateStr)!
        let episode3_7 = Episode(title: "The Queen's Justice", airDate: episodeDate, summary: "Daenerys holds court; Cersei returns a gift.", season: season7)
        dateStr = "06/08/2017"
        episodeDate = format.date(from: dateStr)!
        let episode4_7 = Episode(title: "The Spoils of War", airDate: episodeDate, summary: "The Lannisters pay their debts. Daenerys weighs her options.", season: season7)
        
        // add episodes to seasons
        season1.add(episodes: episode1_1, episode2_1, episode3_1, episode4_1)
        season2.add(episodes: episode1_2, episode2_2, episode3_2, episode4_2)
        season3.add(episodes: episode1_3, episode2_3, episode3_3, episode4_3)
        season4.add(episodes: episode1_4, episode2_4, episode3_4, episode4_4)
        season5.add(episodes: episode1_5, episode2_5, episode3_5, episode4_5)
        season6.add(episodes: episode1_6, episode2_6, episode3_6, episode4_6)
        season7.add(episodes: episode1_7, episode2_7, episode3_7, episode4_7)
        
        return [season1, season2, season3, season4, season5, season6, season7].sorted()
    }
    
    func seasons(filteredBy filter: seasonFilter) -> [Season] {
        return seasons.filter(filter)
    }
}
