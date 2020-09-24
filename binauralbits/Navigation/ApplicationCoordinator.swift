//
//  ApplicationCoordinator.swift
//  binauralbits
//
//  Created by Byron Chavarría on 2/22/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

final class ApplicationCoordinator: Coordinator {
            
    // MARK: - Attributes
    
    let window: UIWindow
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    // MARK: - LifeCycle
    
    init(window: UIWindow) {
        self.window = window
        presenter = UINavigationController()
        presenter.navigationBar.isHidden = true
        window.rootViewController = presenter
    }
    
    // MARK: Start
    
    func start() {
        let controller = HomeViewController()
        controller.viewModel = HomeViewModel(defaultService: DefaultService())
        controller.delegate = self
        presenter.pushViewController(controller, animated: true)
    }
    
    func getSelectedGradient(with numberOfSong: Int, and changeAlpha: Bool) -> [CGColor] {
        let alpha: CGFloat = changeAlpha ? 0.7 : 1
        
        switch numberOfSong {
        case 1:
            let topColor = UIColor(red: 42/255, green: 3/255, blue: 2/255, alpha: alpha)
            let centerColor = UIColor(red: 255/255, green: 27/255, blue: 40/255, alpha: alpha)
            let centerColor1 = UIColor(red: 125/255, green: 22/255, blue: 13/255, alpha: alpha)
            let bottomColor = UIColor(red: 255/255, green: 67/255, blue: 47/255, alpha: alpha)
            return [topColor.cgColor, centerColor1.cgColor, centerColor.cgColor, bottomColor.cgColor]
        case 2:
            let topColor = UIColor(red: 0/255, green: 12/255, blue: 2/255, alpha: alpha)
            let centerColor1 = UIColor(red: 56/255, green: 125/255, blue: 40/255, alpha: alpha)
            let centerColor = UIColor(red: 145/255, green: 193/255, blue: 63/255, alpha: alpha)
            let bottomColor = UIColor(red: 208/255, green: 219/255, blue: 70/255, alpha: alpha)
            return [topColor.cgColor, centerColor1.cgColor, centerColor.cgColor, bottomColor.cgColor]
        case 3:
            let topColor = UIColor(red: 0/255, green: 19/255, blue: 1/255, alpha: alpha)
            let centerColor1 = UIColor(red: 0/255, green: 64/255, blue: 5/255, alpha: alpha)
            let centerColor = UIColor(red: 0/255, green: 118/255, blue: 16/255, alpha: alpha)
            let bottomColor = UIColor(red: 20/255, green: 123/255, blue: 26/255, alpha: alpha)
            return [topColor.cgColor, centerColor1.cgColor, centerColor.cgColor, bottomColor.cgColor]
        case 4:
            let topColor = UIColor(red: 0/255, green: 8/255, blue: 13/255, alpha: alpha)
            let centerColor1 = UIColor(red: 0/255, green: 50/255, blue: 82/255, alpha: alpha)
            let centerColor = UIColor(red: 0/255, green: 112/255, blue: 70/255, alpha: alpha)
            let bottomColor = UIColor(red: 106/255, green: 188/255, blue: 225/255, alpha: alpha)
            return [topColor.cgColor, centerColor1.cgColor, centerColor.cgColor, bottomColor.cgColor]
        default:
            let topColor = UIColor(red: 0/255, green: 1/255, blue: 26/255, alpha: alpha)
            let centerColor1 = UIColor(red: 0/255, green: 8/255, blue: 72/255, alpha: alpha)
            let centerColor = UIColor(red: 0/255, green: 30/255, blue: 136/255, alpha: alpha)
            let bottomColor = UIColor(red: 0/255, green: 42/255, blue: 182/255, alpha: alpha)
            return [topColor.cgColor, centerColor1.cgColor, centerColor.cgColor, bottomColor.cgColor]
        }
    }
    
    func getSelectedImageColor(with numberOfSong: Int) -> UIColor {
        switch numberOfSong {
        case 1:
            return UIColor(red: 232/255, green: 339/255, blue: 106/255, alpha: 1)
        case 2:
            return UIColor(red: 232/255, green: 339/255, blue: 106/255, alpha: 1)
        case 3:
            return UIColor(red: 232/255, green: 339/255, blue: 106/255, alpha: 1)
        case 4:
            return UIColor(red: 232/255, green: 339/255, blue: 106/255, alpha: 1)
        default:
            return UIColor(red: 232/255, green: 339/255, blue: 106/255, alpha: 1)
        }
    }
    
    func handleUnluckProductSelection() {
        let controller = UnluckProductViewController()
        controller.delegate = self
        presenter.pushViewController(controller, animated: true)
    }
    
}

extension ApplicationCoordinator: HomeViewControllerDelegate {
    func homeViewControllerDidSelectInfoPage(with title: String, and subTitle: String, and numberSong: Int) {
        let controller = InformationViewController()
        controller.delegate = self
        controller.hideCloseButton = true
        controller.gradientView.colors = getSelectedGradient(with: numberSong, and: true)
        controller.setupLabel(with: title, and: subTitle)
        presenter.present(controller, animated: true, completion: nil)
    }
    
    func homeViewControllerDidSelectSettingsPage() {
        let controller = SettingsViewController()
        controller.delegate = self
        presenter.pushViewController(controller, animated: true)
    }
    
    func homeViewControllerDidSelectPlayer(with urlToPlay: String, and songName: String, also image: UIImage, finally numberOfSong: Int) {
        if songName == "Creatividad" || KeychainWrapper.standard.bool(forKey: K.premiumUserKey) ?? false {
            let controller = PlayerViewController()
            controller.songUrl = urlToPlay
            controller.songName = songName
            controller.principalImage.image = image
            controller.backgroundImage.tintColor = getSelectedImageColor(with: numberOfSong)
            controller.gradientView.colors = getSelectedGradient(with: numberOfSong, and: false)
            controller.delegate = self
            presenter.pushViewController(controller, animated: true)
        } else {
            let alert = UIAlertController(title: L10n.weSorry, message: L10n.purchaseMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: L10n.purchasePremiunButtonText, style: .default) { (actions: UIAlertAction) in
                alert.dismiss(animated: true, completion: {
                    self.handleUnluckProductSelection()
                })
            }
            alert.addAction(alertAction)
            presenter.present(alert, animated: true, completion: nil)
        }
    }
}

extension ApplicationCoordinator: PlayerViewControllerDelegate {
    func playerViewControllerDidSelectSettingsPage() {
        let controller = SettingsViewController()
        controller.delegate = self
        presenter.pushViewController(controller, animated: true)
    }
    
    func playerViewControllerDidSelectBack() {
        presenter.popViewController(animated: true)
    }
}

extension ApplicationCoordinator: SettingsViewControllerDelegate {
    func settingsViewControllerDidSelectUnluckProduct() {
        handleUnluckProductSelection()
    }
    
    
    func settingsViewControllerDidSelectContact() {
        let controller = InformationViewController()
        controller.delegate = self
        controller.hideCloseButton = false
        controller.view.backgroundColor = R.Colors.contactSupportViewColor.color
        controller.setupLabel(with: L10n.contacTitle, and: L10n.contactDescription)
        presenter.pushViewController(controller, animated: true)
    }
    
    func settingsViewControllerDidSelectCopyrights() {
        let controller = InformationViewController()
        controller.delegate = self
        controller.hideCloseButton = false
        controller.view.backgroundColor = R.Colors.contactSupportViewColor.color
        controller.setupLabel(with: L10n.copyrightsTitle, and: L10n.copyrightsDescription)
        presenter.pushViewController(controller, animated: true)
    }
    
    func settingsViewControllerDidSelectHowItWorks() {
        let controller = InformationViewController()
        controller.delegate = self
        controller.hideCloseButton = false
        controller.view.backgroundColor = R.Colors.contactSupportViewColor.color
        controller.setupLabel(with: L10n.howItWorksTitle, and: L10n.howItWorksDescription)
        presenter.pushViewController(controller, animated: true)
    }
    
    func settingsViewControllerDidSelectClose() {
        presenter.popViewController(animated: true)
    }
    
    func settingsViewControllerDidSelectContactSupport() {
        let controller = InformationViewController()
        controller.delegate = self
        controller.hideCloseButton = false
        controller.view.backgroundColor = R.Colors.contactSupportViewColor.color
        controller.setupLabel(with: L10n.principalInfoPageTitle, and: L10n.principalInfoPageDetail)
        presenter.pushViewController(controller, animated: true)
    }
}

extension ApplicationCoordinator: InformationViewControllerDelegate {
    func informationViewControllerDidSelectBack() {
        presenter.popViewController(animated: true)
    }
}

extension ApplicationCoordinator: UnluckProductViewControllerDelegate {
    func unluckProductViewControllerDidHaveToClose() {
        presenter.popToRootViewController(animated: true)
    }
    
    func unluckProductViewControllerDidSelectCancel() {
        presenter.popToRootViewController(animated: true)
    }
}

