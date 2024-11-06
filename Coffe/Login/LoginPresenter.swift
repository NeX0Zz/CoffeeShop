//
//  LoginPresenter.swift
//  Coffe
//
//  Created by Денис Николаев on 29.10.2024.
//

import UIKit

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    var router: LoginRouterProtocol?
    
    func registrationRouter() {
        guard let viewController = view as? UIViewController else { return }
        let registrationViewController = RegistrationRouter.createModule() // Create the registration module
        viewController.navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    func login(email: String, password: String) {
        interactor?.loginUser(email: email, password: password)
    }
    
    func loginDidSucceed(message: String, token: String) {
        print("Сохранение токена: \(token)")
        UserDefaults.standard.set(token, forKey: "authToken")
        view?.showLoginSuccess(message: message)
    }
    func loginDidFail(error: String) {
        view?.showLoginFailure(error: error)
    }
    
    func loginSuccess() {
        view?.showLoginSuccess(message: "Вход выполнен успешно")
        router?.navigateToNearbyCafes()
    }
}
