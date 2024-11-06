//
//  LoginRouter.swift
//  Coffe
//
//  Created by Денис Николаев on 29.10.2024.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = LoginViewController()
        let presenter: LoginPresenterProtocol = LoginPresenter()
        var interactor: LoginInteractorProtocol = LoginInteractor()
        var router: LoginRouterProtocol = LoginRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToNearbyCafes() {
            let nearbyCafesVC = NearbyCafesRouter.createModule()
            viewController?.navigationController?.pushViewController(nearbyCafesVC, animated: true)
        }
}
