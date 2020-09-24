//
//  SettingsViewControllerDelegate.swift
//  binauralbits
//
//  Created by Byron Chavarría on 6/20/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import Foundation

protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerDidSelectClose()
    func settingsViewControllerDidSelectContactSupport()
    func settingsViewControllerDidSelectHowItWorks()
    func settingsViewControllerDidSelectContact()
    func settingsViewControllerDidSelectCopyrights()
    func settingsViewControllerDidSelectUnluckProduct()
}
