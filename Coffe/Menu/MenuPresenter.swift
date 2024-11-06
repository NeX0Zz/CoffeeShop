//
//  MenuPresenter.swift
//  Coffe
//
//  Created by Денис Николаев on 01.11.2024.
//

import UIKit

class MenuPresenter: MenuPresenterProtocol {
    weak var view: MenuViewProtocol?
    private var interactor: MenuInteractorProtocol
    private var router: MenuRouterProtocol
    private let coffeeShop: CoffeeShop
    
    private var cartItems: [MenuItem] = []
    
    init(view: MenuViewProtocol, interactor: MenuInteractorProtocol, router: MenuRouterProtocol, coffeeShop: CoffeeShop) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.coffeeShop = coffeeShop
    }
    
    func getMenu(locationId: String) {
        interactor.getMenu(locationId: "\(coffeeShop.id)")
    }
    
    func didFetchMenu(menuItems: [MenuItem]) {
        view?.showMenu(menuItems)
    }
    
    func didTapAddItem(_ item: MenuItem) {
            cartItems.append(item)
        }
        
        func didTapRemoveItem(_ item: MenuItem) {
            if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
                cartItems.remove(at: index)
            }
        }
    
    func didFailToFetchMenu(error: String) {
        view?.showError(error)
    }
    
    func goToCart(with items: [MenuItem]) {
        let nonZeroQualityItems = items.filter { $0.quality ?? 0 > 0 }
        router.navigateToCart(with: nonZeroQualityItems)
    }
}
