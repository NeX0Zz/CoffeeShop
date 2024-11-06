//
//  MenuRouter.swift
//  Coffe
//
//  Created by Денис Николаев on 01.11.2024.
//

import UIKit

class MenuRouter: MenuRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToMenuItemDetails(with item: MenuItem) {
        let detailsVC = MenuViewController()
        detailsVC.items.append(item)
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func navigateToCart(with items: [MenuItem]) {
        let cartViewController = CartRouter.createCartModule(with: items)
        viewController?.navigationController?.pushViewController(cartViewController, animated: true)
    }
}


class MenuModuleBuilder {
    static func build(with coffeeShop: CoffeeShop) -> UIViewController {
        let view = MenuViewController()
        let interactor = MenuInteractor()
        let router = MenuRouter(viewController: view)
        let presenter = MenuPresenter(view: view, interactor: interactor, router: router, coffeeShop: coffeeShop)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

