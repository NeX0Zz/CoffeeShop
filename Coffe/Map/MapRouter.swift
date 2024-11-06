//
//  MapRouter.swift
//  Coffe
//
//  Created by Денис Николаев on 01.11.2024.
//
import Foundation

class MapModuleBuilder {
    static func build(with coffeeShop: [CoffeeShop]) -> MapViewController {
        let mapViewController = MapViewController()
        mapViewController.coffeeShop = coffeeShop 
        return mapViewController
    }
}
