//
//  RegistrationRouter.swift
//  Coffe
//
//  Created by Денис Николаев on 29.10.2024.
//

import UIKit

class RegistrationRouter: RegistrationRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = RegistrationViewController()
        let presenter = RegistrationPresenter()
        let interactor = RegistrationInteractor()
        let router = RegistrationRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        
        return view
    }
}
