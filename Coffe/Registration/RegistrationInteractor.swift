//
//  RegistrationInteractor.swift
//  Coffe
//
//  Created by Денис Николаев on 29.10.2024.
//

import Foundation

import Moya

class RegistrationInteractor: RegistrationInteractorProtocol {
    private let provider = MoyaProvider<AuthAPI>()
    
    func registerUser(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        provider.request(.register(email: email, password: password)) { result in
            switch result {
            case .success(let response):
                do {
                    let registrationResponse = try JSONDecoder().decode(RegistrationResponse.self, from: response.data)
                    if let token = registrationResponse.token {
                        completion(true, "Вы успешно зарегестрировались!")
                    } else {
                        completion(false, "Токен не получен")
                    }
                } catch {
                    completion(false, "Ошибка декодирования данных")
                    print("Response data:", String(data: response.data, encoding: .utf8) ?? "Unable to print response data")
                }
            case .failure(let error):
                completion(false, error.localizedDescription)
                print("Error:", error)
            }
        }
    }
}

struct RegistrationRequest: Codable {
    let login: String
    let password: String
}

struct RegistrationResponse: Codable {
    let token: String?
    let tokenLifetime: Int
}

import Moya

enum AuthAPI {
    case register(email: String, password: String)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://147.78.66.203:3210")!
    }
    
    var path: String {
        switch self {
        case .register:
            return "/auth/register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .register(let email, let password):
            let parameters = ["login": email, "password": password]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        return Data() // You can provide sample data for unit testing
    }
}

protocol RegistrationInteractorProtocol {
    func registerUser(email: String, password: String, completion: @escaping (Bool, String?) -> Void)
}
