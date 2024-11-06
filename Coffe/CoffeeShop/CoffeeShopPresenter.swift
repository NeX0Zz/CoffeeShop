//
//  CoffeeShopPresenter.swift
//  Coffe
//
//  Created by Денис Николаев on 31.10.2024.
//

import Foundation
import CoreLocation

class NearbyCafesPresenter: NearbyCafesPresenterProtocol, NearbyCafesInteractorOutputProtocol {
    weak var view: NearbyCafesViewProtocol?
    var interactor: NearbyCafesInteractorProtocol?
    var router: NearbyCafesRouterProtocol?
    private let locationManager = LocationManager()
    
    init(view: NearbyCafesViewProtocol, interactor: NearbyCafesInteractorProtocol, router: NearbyCafesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor?.fetchNearbyCafes(latitude: locationManager.currentLocation?.coordinate.latitude ?? 0, longitude: locationManager.currentLocation?.coordinate.longitude ?? 0)
        
    }
    
    func didSelectCoffeeShop(_ coffeeShop: CoffeeShop) {
        router?.navigateToMenu(for: coffeeShop)
    }
    
    func navigateToMap(with coffeeShop: [CoffeeShop]) {
        router?.navigateToMap(with: coffeeShop)
    }
}

extension NearbyCafesPresenter {
    func didFetchCoffeeShops(_ coffeeShops: [CoffeeShop]) {
        view?.displayCoffeeShops(coffeeShops)
        
    }
    
    func didFailFetchingCoffeeShops(with error: String) {
        view?.showError(error)
    }
    
    func didFetchCoffeeShopsWithDistance(_ coffeeShops: [(CoffeeShop, CLLocationDistance)]) {
        view?.displayCoffeeShopsWithDistance(coffeeShops)
    }
}
