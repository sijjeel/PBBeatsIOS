//
//  UnluckProductViewModel.swift
//  binauralbits
//
//  Created by Byron Chavarría on 9/22/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import Foundation
import StoreKit

protocol UnluckProductViewModelDelegate {
    func showIAPRelatedError(_ error: Error)
    func didFinishRestoringPurchasesWithZeroProducts()
    func didFinishRestoringPurchasedProducts()
    func successPurchase()
}


class UnluckProductViewModel {
    
    // MARK: - Properties
    
    var delegate: UnluckProductViewModelDelegate?
    
    // MARK: - Init
    
    init() {
        
    }
    
    // MARK: - Methods To Implement
    
    func purchase(product: SKProduct) -> Bool {
        if !IAPManager.shared.canMakePayments() {
            return false
        } else {
            IAPManager.shared.buy(product: product) { (result) in
                DispatchQueue.main.async {
                    
                    switch result {
                    case .success(_): self.delegate?.successPurchase()
                    case .failure(let error): self.delegate?.showIAPRelatedError(error)
                    }
                }
            }
        }
        
        return true
    }
    
    func restorePurchases() {
        IAPManager.shared.restorePurchases { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let success):
                    if success {
                        self.delegate?.didFinishRestoringPurchasedProducts()
                    } else {
                        self.delegate?.didFinishRestoringPurchasesWithZeroProducts()
                    }
                    
                case .failure(let error): self.delegate?.showIAPRelatedError(error)
                }
            }
        }
    }
}

