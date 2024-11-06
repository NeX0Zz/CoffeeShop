//
//  LoginProtocols.swift
//  Coffe
//
//  Created by Денис Николаев on 29.10.2024.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func showLoginSuccess(message: String)
    func showLoginFailure(error: String)
    var navigationController: UINavigationController? { get }
}

protocol LoginPresenterProtocol: AnyObject {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    func registrationRouter()
    
    func login(email: String, password: String)
    func loginDidSucceed(message: String, token: String)
    func loginDidFail(error: String)
}

protocol LoginInteractorProtocol {
    var presenter: LoginPresenterProtocol? { get set }
    func loginUser(email: String, password: String)
}

protocol LoginRouterProtocol {
    var viewController: UIViewController? { get set }
    static func createModule() -> UIViewController
    func navigateToNearbyCafes()
}

