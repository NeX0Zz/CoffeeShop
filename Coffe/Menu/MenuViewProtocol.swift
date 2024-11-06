//
//  MenuViewProtocol.swift
//  Coffe
//
//  Created by Денис Николаев on 01.11.2024.
//

import UIKit

protocol MenuViewProtocol: AnyObject {
    var presenter: MenuPresenterProtocol? { get set }
    func showMenu(_ menuItems: [MenuItem])
    func showError(_ message: String)
}

protocol MenuInteractorProtocol: AnyObject {
    var presenter: MenuPresenterProtocol? { get set }
    func getMenu(locationId: String)
}

protocol MenuPresenterProtocol: AnyObject {
    var view: MenuViewProtocol? { get set }
    func didFetchMenu(menuItems: [MenuItem])
    func didFailToFetchMenu(error: String)
    func getMenu(locationId: String)
    func goToCart(with items: [MenuItem])
}

protocol MenuRouterProtocol: AnyObject {
    func navigateToMenuItemDetails(with item: MenuItem)
    func navigateToCart(with items: [MenuItem])
}
