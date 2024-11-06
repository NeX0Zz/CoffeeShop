//
//  MenuService.swift
//  Coffe
//
//  Created by Денис Николаев on 01.11.2024.
//

import Foundation
import Moya

enum MenuService {
    case getMenu(locationId: String)
    var token: String? {
        return UserDefaults.standard.string(forKey: "authToken")
    }
}

extension MenuService: TargetType {
    var baseURL: URL {
        return URL(string: "http://147.78.66.203:3210")!
    }

    var path: String {
        switch self {
        case .getMenu(let locationId):
            return "/location/\(locationId)/menu"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]
        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var sampleData: Data {
        return Data()
    }
}
