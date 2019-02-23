//
//  Character.swift
//  Westeros
//
//  Created by Jon Gonzalez on 31/01/2019.
//  Copyright © 2019 Jon Gonzalez. All rights reserved.
//

import UIKit

final class Person {
    
    // MARK: Properties
    let name: String
    private let _alias: String?
    let house: House
    let image: UIImage
    
    // Propiedad computada
    var alias: String {
        get {
//            if let alias = _alias {
//                return alias
//            } else {
//                return ""
//            }
//            guard let alias = _alias else {
//                // no existe
//                return ""
//            }
//            // existe y está en alias
//            return alias
            
            // Usar operador ternario: devuelve _alias si tiene algo, y si no tiene nada devuelve ""
            return _alias ?? ""
        }
    }
    
    // MARK: Initialization
    init(name: String, alias: String? = nil, house: House, image: UIImage) {
        self.name = name
        _alias = alias
        self.house = house
        self.image = image
    }
    
//    // Los convenience inits tienen que llamar a self.init (el designado) obligatoriamente
//    convenience init(name: String, house: House) {
//        self.init(name: name, alias: nil, house: house)
//    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

extension Person {
    var proxyForEquality: String {
        return "\(name) \(alias) \(house.name)"
    }
    
    var proxyForComparison: String {
        return fullName
    }
}

// Si dos objetos tienen el mismo hash, significa que tienen que ser iguales
// A la inversa no es necesariamente cierta: 2 objetos pueden ser iguales y no tener el mismo hash
extension Person: Hashable { // Identidad
    // Con proxy, le pasamos el marrón de calcular el hash u otra cosa a otro objeto
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Person: Equatable{
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
