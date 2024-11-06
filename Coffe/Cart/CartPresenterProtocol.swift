//
//  CartPresenterProtocol.swift
//  Coffe
//
//  Created by Денис Николаев on 04.11.2024.
//


protocol CartPresenterProtocol: AnyObject {
    var view: CartViewProtocol? { get set }
    func addToCart(item: MenuItem)
    func removeFromCart(item: MenuItem)
    func getCartItems() -> [MenuItem]
}

protocol CartRouterProtocol: AnyObject {
    func navigateToCart(with items: [MenuItem])
}
