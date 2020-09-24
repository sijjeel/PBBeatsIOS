//
//  UIViewController+errorHandling.swift
//  binauralbits
//
//  Created by Byron Chavarría on 5/4/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit

extension UIViewController {
    internal func handleOperationResult(type: ActionModalType, height: Float = 180, handler: (() -> Void)? = nil) {
        //let actionViewController = ActionModalViewControlle.instantiate()
//        actionViewController.actionableModal = type
//        actionViewController.handler = handler
        
        presentModal(
            UIViewController(),
            width: .fluid(percentage: 0.8),
            height: .custom(size: height),
            backgroundOpacity: 0.8
        )
    }
}

