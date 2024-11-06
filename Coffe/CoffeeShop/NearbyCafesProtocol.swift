//
//  Protocol.swift
//  Coffe
//
//  Created by Денис Николаев on 31.10.2024.
//

import UIKit
import CoreLocation

protocol NearbyCafesViewProtocol: AnyObject {
    func displayCoffeeShops(_ coffeeShops: [CoffeeShop])
    func displayCoffeeShopsWithDistance(_ coffeeShops: [(CoffeeShop, CLLocationDistance)])
    func showError(_ message: String)
}

protocol NearbyCafesPresenterProtocol: AnyObject {
    var view: NearbyCafesViewProtocol? { get set }
    var interactor: NearbyCafesInteractorProtocol? { get set }
    var router: NearbyCafesRouterProtocol? { get set }
    func didSelectCoffeeShop(_ coffeeShop: CoffeeShop)
    func viewDidLoad()
}

protocol NearbyCafesInteractorProtocol: AnyObject {
    var presenter: NearbyCafesInteractorOutputProtocol? { get set }
    func fetchNearbyCafes(latitude: Double, longitude: Double)
    func calculateDistances(for coffeeShops: [CoffeeShop])
    func startLocationUpdates()
}

protocol NearbyCafesInteractorOutputProtocol: AnyObject {
    func didFetchCoffeeShops(_ coffeeShops: [CoffeeShop])
    func didFailFetchingCoffeeShops(with error: String)
    func didFetchCoffeeShopsWithDistance(_ coffeeShops: [(CoffeeShop, CLLocationDistance)])
    func navigateToMap(with coffeeShop: [CoffeeShop])
}

protocol NearbyCafesRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToMenu(for coffeeShop: CoffeeShop)
    func navigateToMap(with coffeeShop: [CoffeeShop])
}
