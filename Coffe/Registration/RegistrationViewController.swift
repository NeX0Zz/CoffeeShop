//
//  RegistrationViewController.swift
//  Coffe
//
//  Created by Денис Николаев on 28.10.2024.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController, RegistrationViewProtocol, UITextFieldDelegate {
    var presenter: RegistrationPresenterProtocol!
    
    private let emailTextField = PaddedTextField()
    private let passwordTextField = PaddedTextField()
    private let passwordAgainTextField = PaddedTextField()
    private let registerButton = UIButton()
    
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
    
    private let paasswordAgainLabel: UILabel = {
        let label = UILabel()
        label.text = "Повторите пароль"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Регистрация"
        setupUI()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self
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
        
        passwordAgainTextField.placeholder = "*******"
        passwordAgainTextField.isSecureTextEntry = true
        passwordAgainTextField.layer.cornerRadius = 24.5
        passwordAgainTextField.layer.borderWidth = 2.0
        passwordAgainTextField.layer.borderColor = CGColor(srgbRed: 132/255, green: 99/255, blue: 64/255, alpha: 1)
        view.addSubview(passwordAgainTextField)
        
        registerButton.setTitle("Регистрация", for: .normal)
        registerButton.backgroundColor = UIColor(red: 52/255, green: 45/255, blue: 26/255, alpha: 1)
        registerButton.setTitleColor(UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1), for: .normal)
        registerButton.layer.cornerRadius = 24.5
        registerButton.layer.borderWidth = 2.0
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        view.addSubview(registerButton)
        
        view.addSubview(emailLabel)
        view.addSubview(paasswordLabel)
        view.addSubview(paasswordAgainLabel)
        
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
        
        view.addSubview(paasswordAgainLabel)
        paasswordAgainLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(18)
        }
        
        view.addSubview(passwordAgainTextField)
        passwordAgainTextField.snp.makeConstraints { make in
            make.top.equalTo(paasswordAgainLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(47)
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordAgainTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(47)
        }
    }
    
    @objc private func didTapRegisterButton() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let passwordAgain = passwordAgainTextField.text ?? ""
        guard password == passwordAgain else {
            showAlert(title: "Ошибка!", message: "Пароли не совпадают.")
            return
        }
        presenter.registerUser(email: email, password: password)
    }
    
    private func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showRegistrationResult(success: Bool, message: String?) {
        let alert = UIAlertController(title: success ? "Успех!" : "Ошибка!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class PaddedTextField: UITextField {
    var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 8)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
