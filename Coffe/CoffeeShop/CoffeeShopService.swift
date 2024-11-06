//
//  CoffeeShopService.swift
//  Coffe
//
//  Created by Денис Николаев on 31.10.2024.
//

import Foundation
import Moya

enum CafeAPI {
    case nearbyCafes(lat: Double, lon: Double)
    
    var token: String? {
        return UserDefaults.standard.string(forKey: "authToken")
    }
}

extension CafeAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://147.78.66.203:3210")!
    }
    
    var path: String {
        switch self {
        case .nearbyCafes:
            return "/locations"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .nearbyCafes(let lat, let lon):
            let parameters = ["latitude": lat, "longitude": lon]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]
        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
    
    var sampleData: Data {
        return Data()
    }
}
