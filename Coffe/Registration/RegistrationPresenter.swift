//
//  RegistrationPresenter.swift
//  Coffe
//
//  Created by Денис Николаев on 29.10.2024.
//

import Foundation

class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var view: RegistrationViewProtocol?
    var interactor: RegistrationInteractorProtocol?
    var router: RegistrationRouterProtocol?
    
    func registerUser(email: String, password: String) {
        interactor?.registerUser(email: email, password: password) { [weak self] success, message in
            self?.view?.showRegistrationResult(success: success, message: message)
        }
    }
}

