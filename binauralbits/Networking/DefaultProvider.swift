//
//  DefaultProvider.swift
//  binauralbits
//
//  Created by Byron Chavarría on 5/4/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import Moya
import RxSwift

enum DefaultProvider {
    case songs
    case receipt(data: String)
}

// MARK: - TargetType

extension DefaultProvider: TargetType {
    var baseURL: URL {
        switch self {
        case .songs:
            return URL(string: K.baseURL)!
        default:
            return K.isProduction ? URL(string: K.receiptURL)! : URL(string: K.receiptTestURL)!
        }
    }

    var path: String {
        switch self {
            case .songs: return "/Songs"
        case .receipt: return "/verifyReceipt"
        }
    }

    var method: Moya.Method {
        switch self {
        case .songs:
            return .get
        case .receipt:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        var parameters: [String: Any] = [:]
        switch self {
        case .songs:
            return .requestPlain
            
        case let .receipt(data):
            parameters["receipt-data"] = data
            parameters["password"] = K.sharedSecretKey
            parameters["exclude-old-transactions"] = true
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return K.MoyaDefaults.defaultHeaders
    }
}

