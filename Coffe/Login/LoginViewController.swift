//
//  LoginViewController.swift
//  Coffe
//
//  Created by Денис Николаев on 29.10.2024.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    var presenter: LoginPresenterProtocol?
    
    private let emailTextField = PaddedTextField()
    private let passwordTextField = PaddedTextField()
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "e-mail"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1)
        return label
    }()
    
    private let paasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1)
        return label
    }()
    
    private let registerButton = UIButton()
    
    private let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
        title = "Вход"
        setupUI()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        emailTextField.placeholder = "example@example.ru"
        emailTextField.layer.cornerRadius = 24.5
        emailTextField.layer.borderWidth = 2.0
        emailTextField.layer.borderColor = CGColor(srgbRed: 132/255, green: 99/255, blue: 64/255, alpha: 1)
        view.addSubview(emailTextField)
        
        passwordTextField.placeholder = "*******"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.cornerRadius = 24.5
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = CGColor(srgbRed: 132/255, green: 99/255, blue: 64/255, alpha: 1)
        view.addSubview(passwordTextField)
        
        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = UIColor(red: 52/255, green: 45/255, blue: 26/255, alpha: 1)
        loginButton.setTitleColor(UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1), for: .normal)
        loginButton.layer.cornerRadius = 24.5
        loginButton.layer.borderWidth = 2.0
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        view.addSubview(loginButton)
        
        view.addSubview(emailLabel)
        view.addSubview(paasswordLabel)
        
        registerButton.setTitle("Регистрация", for: .normal)
        registerButton.backgroundColor = UIColor(red: 52/255, green: 45/255, blue: 26/255, alpha: 1)
        registerButton.setTitleColor(UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1), for: .normal)
        registerButton.layer.cornerRadius = 24.5
        registerButton.layer.borderWidth = 2.0
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        view.addSubview(registerButton)
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(216)
            make.leading.equalToSuperview().inset(18)
        }
        
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(47)
        }
        
        view.addSubview(paasswordLabel)
        
        paasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(25)
            make.leading.equalToSuperview().inset(18)
        }
        
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(paasswordLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(47)
        }
        
        
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(47)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(47)
        }
        
    }
    
    @objc private func didTapRegister() {
        presenter?.registrationRouter() // Navigate to the registration screen
    }
    
    //    @objc private func didTapLogin() {
    //        if let token = UserDefaults.standard.string(forKey: "authToken"), !token.isEmpty {
    //            print("Токен найден при запуске: \(token)")
    //            presenter?.router?.navigateToNearbyCafes()
    //            //переделать
    //        } else {
    //            let email = emailTextField.text ?? ""
    //            let password = passwordTextField.text ?? ""
    //            presenter?.login(email: email, password: password)
    //        }
    //    }
    
    private func navBarSetup() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.ColorText]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.ColorText
    }
    @objc private func didTapLogin() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Пожалуйста, введите e-mail и пароль.")
            return
        }
        
        presenter?.login(email: email, password: password)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController: LoginViewProtocol {
    func showLoginSuccess(message: String) {
        print("Успешный вход: \(message)")
        presenter?.router?.navigateToNearbyCafes()
    }
    
    func showLoginFailure(error: String) {
        print("Ошибка входа: \(error)")
        showAlert(message: error)
    }
}
