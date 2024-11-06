//
//  CartRouter.swift
//  Coffe
//
//  Created by Денис Николаев on 04.11.2024.
//

import UIKit


class CartRouter: CartRouterProtocol {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func navigateToCart(with items: [MenuItem]) {
        let cartViewController = CartRouter.createCartModule(with: items)
        viewController?.navigationController?.pushViewController(cartViewController, animated: true)
    }

    static func createCartModule(with items: [MenuItem]) -> UIViewController {
        let view = CartViewController()
        let interactor = CartInteractor()
        let router = CartRouter(viewController: view)
        let presenter = CartPresenter(view: view, interactor: interactor, router: router, items: items)
        
        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}
