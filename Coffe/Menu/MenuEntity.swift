//
//  Entity.swift
//  Coffe
//
//  Created by Денис Николаев on 01.11.2024.
//

struct MenuItem: Decodable {
    let id: Int
    let name: String
    let imageURL: String
    let price: Int
    var quality: Int?
}
