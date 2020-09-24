//
//  StatusCodes.swift
//  binauralbits
//
//  Created by Byron Chavarría on 8/1/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import Foundation

enum StatusCodes: Int {
    case success = 0
    case expiredSubscription = 21006
    case userAccountNotFoundOrDeleted = 21010
    case unavailableServer = 21005
    case authenticationError = 21003
    case errorParsingReciept = 21002
}
