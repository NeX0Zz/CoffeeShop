//
//  CartPresenter.swift
//  Coffe
//
//  Created by Денис Николаев on 04.11.2024.
//


class CartPresenter: CartPresenterProtocol {
    weak var view: CartViewProtocol?
    private var interactor: CartInteractorProtocol
    private var router: CartRouterProtocol
    private var cartItems: [MenuItem] = []

    init(view: CartViewProtocol, interactor: CartInteractorProtocol, router: CartRouterProtocol, items: [MenuItem]) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.cartItems = items
    }
    
    func getCartItems() -> [MenuItem] {
            return cartItems
        }
    
    func addToCart(item: MenuItem) {
        cartItems.append(item)
        view?.showCartItems(cartItems)
    }
    
    func removeFromCart(item: MenuItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems.remove(at: index)
        }
        view?.showCartItems(cartItems)
    }
}
