//
//  CoffeeEntity.swift
//  Coffe
//
//  Created by Денис Николаев on 01.11.2024.
//

struct CoffeeShop: Codable {
    let id: Int
    let name: String
    let point: Coordinates
}

struct Coordinates: Codable {
    let latitude: String
    let longitude: String

    var latitudeDouble: Double? {
        return Double(latitude)
    }

    var longitudeDouble: Double? {
        return Double(longitude)
    }
}
