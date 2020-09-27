//
//  K.swift
//  binauralbits
//
//  Created by Byron Chavarría on 5/4/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit
import Moya

enum K {
//    static let baseURL = "https://pbbsapi.azurewebsites.net/api"
    static let baseURL = "https://pbbpapi.azurewebsites.net/api"
    static let receiptURL = "https://buy.itunes.apple.com"
    static let receiptTestURL = "https://sandbox.itunes.apple.com"
    
    enum Components {
        static let navigationBarHeight: CGFloat = 64
    }
    
    static let isProduction = false
    static let premiumUserKey = "PremiumUserKey"
    static let sharedSecretKey = "0017936b1de94bc997fcba1d27c7104a"
    
    static var isPurchased = false
    
    // Moya
    enum MoyaDefaults {
        static let plugins: [PluginType] = [
            NetworkLoggerPlugin(),
            SecureRequestPlugin()
        ]
        static let secureMethods: [Moya.Method] = [.get, .post]
        static let defaultHeaders = [
            "Content-Type": "application/json",
        ]
    }
}

