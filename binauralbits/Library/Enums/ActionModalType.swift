//
//  ActionModalType.swift
//  binauralbits
//
//  Created by Byron Chavarría on 5/4/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import Foundation

enum ActionModalType {
    case exception(description: String)
    case success(description: String)
    case feddbackSuccess(description: String)
    case loan(heading: String, title: String, subtitle: String)
    case debitCardLock(message: String)
}

// MARK: - ActionableModal

extension ActionModalType: ActionableModal {
    var title: String {
        switch self {
        case .exception:
            return ""
            
        case .success:
            return "Correcto!"
            
        case .feddbackSuccess:
            return "Hemos recibido sus comentarios"
            
        case .debitCardLock:
            return "Se ha enviado tu reporte"
            
        case let .loan(_, title, _): return title
        }
    }
    
    var subtitle: String {
        switch self {
        case let .exception(description):
            return description
            
        case let .success(description):
            return description
            
        case let .feddbackSuccess(description):
            return description
            
        case let .debitCardLock(message):
            return message
            
        case let .loan(_, _, subtitle): return subtitle
        }
    }
    
    var actionTitle: String {
        switch self {
        case .exception, .success, .loan, .feddbackSuccess, .debitCardLock:
            return "OK"
        }
    }
    
    var isDismissable: Bool {
        switch self {
        case .exception, .success, .loan, .feddbackSuccess, .debitCardLock:
            return true
        }
    }
    
    var headingIsHidden: Bool {
        switch self {
        case .loan: return false
        default: return true
        }
    }
    
    var headingTitle: String? {
        switch self {
        case let .loan(heading, _, _): return heading
        default: return nil
        }
        
    }
}

