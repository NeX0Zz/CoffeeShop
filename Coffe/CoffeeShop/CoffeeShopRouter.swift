//
//  CoffeeShopRouter.swift
//  Coffe
//
//  Created by Денис Николаев on 31.10.2024.
//

import UIKit

class NearbyCafesRouter: NearbyCafesRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = NearbyCafesViewController()
        let router = NearbyCafesRouter()
        let interactor = NearbyCafesInteractor()
        let presenter = NearbyCafesPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToMenu(for coffeeShop: CoffeeShop) {
        let menuViewController = MenuModuleBuilder.build(with: coffeeShop)
        viewController?.navigationController?.pushViewController(menuViewController, animated: true)
    }
    
    func navigateToMap(with coffeeShop: [CoffeeShop]) {
          let mapViewController = MapModuleBuilder.build(with: coffeeShop)
          viewController?.navigationController?.pushViewController(mapViewController, animated: true)
      }
}
