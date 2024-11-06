//
//  CartViewProtocol.swift
//  Coffe
//
//  Created by Денис Николаев on 04.11.2024.
//


protocol CartViewProtocol: AnyObject {
    var presenter: CartPresenterProtocol? { get set }
    func showCartItems(_ items: [MenuItem])
}
