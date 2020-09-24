//
//  UIViewController+presentr.swift
//  binauralbits
//
//  Created by Byron Chavarría on 5/4/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit
import Presentr

extension UIViewController {
    func presentModal(
        _ viewController: UIViewController,
        width: ModalSize,
        height: ModalSize,
        backgroundOpacity: Float,
        completition: (() -> Void)? = nil) {
        
        let presenter = Presentr.defaultPresenter(width: width, height: height)
        presenter.backgroundColor = .black
        presenter.backgroundOpacity = backgroundOpacity
        presenter.dismissOnSwipe = false
        presenter.roundCorners = true
        presenter.cornerRadius = 8
        
        self.customPresentViewController(
            presenter,
            viewController: viewController,
            animated: true,
            completion: completition
        )
    }
}
