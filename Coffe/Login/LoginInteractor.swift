//
//  LoginInteractor.swift
//  Coffe
//
//  Created by Денис Николаев on 29.10.2024.
//
import Foundation
import Moya

class LoginInteractor: LoginInteractorProtocol {
    private let provider = MoyaProvider<AuthAPIi>()
    var presenter: LoginPresenterProtocol?
    
    func loginUser(email: String, password: String) {
        provider.request(.login(login: email, password: password)) { result in
            switch result {
            case .success(let response):
                print("Response data: \(String(data: response.data, encoding: .utf8) ?? "nil")")
                if (200...299).contains(response.statusCode) {
                    do {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                        let token = loginResponse.token
                        UserDefaults.standard.set(token, forKey: "authToken")
                        self.presenter?.loginDidSucceed(message: "Login successful", token: token)
                    } catch {
                        print("Decoding error: \(error)")
                        self.presenter?.loginDidFail(error: "Ошибка декодирования данных: Неверный логин или пароль")
                    }
                } else {
                    let errorMessage: String
                    switch response.statusCode {
                    case 401:
                        errorMessage = "Неверный логин или пароль."
                    case 403:
                        errorMessage = "Доступ запрещен."
                    case 500:
                        errorMessage = "Ошибка сервера. Попробуйте позже."
                    default:
                        errorMessage = "Неизвестная ошибка. Попробуйте позже."
                    }
                    self.presenter?.loginDidFail(error: errorMessage)
                }
            case .failure(let error):
                self.presenter?.loginDidFail(error: "Ошибка сети: \(error.localizedDescription)")
            }
        }
    }
}

struct LoginResponse: Codable {
    let token: String
    let tokenLifetime: Int
}

enum AuthAPIi {
    case login(login: String, password: String)
}

extension AuthAPIi: TargetType {
    var baseURL: URL {
        return URL(string: "http://147.78.66.203:3210")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password):
            let parameters = ["login": email, "password": password]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        var headers: [String: String] = ["Content-Type": "application/json"]
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
    
    var sampleData: Data {
        return Data()
    }
}
