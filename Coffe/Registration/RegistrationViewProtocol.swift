//
//  RegistrationViewProtocol.swift
//  Coffe
//
//  Created by Денис Николаев on 05.11.2024.
//

import UIKit

protocol RegistrationViewProtocol: AnyObject {
    var presenter: RegistrationPresenterProtocol! { get set }
    func showRegistrationResult(success: Bool, message: String?)
}

protocol RegistrationPresenterProtocol: AnyObject {
    var view: RegistrationViewProtocol? { get set }
    var interactor: RegistrationInteractorProtocol? { get set }
    var router: RegistrationRouterProtocol? { get set }
    func registerUser(email: String, password: String)
}

protocol RegistrationRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}
