//
//  SettingsViewController.swift
//  binauralbits
//
//  Created by Byron Chavarría on 3/7/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: - Components
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var closebutton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.Images.closeIcon.image, for: .normal)
        return button
    }()
    
    lazy var settingsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributtedText = NSMutableAttributedString.attributedString(
            L10n.settingsTitle,
            font: .systemFont(ofSize: 26, weight: .bold),
            color: .white
        )
        label.attributedText = attributtedText
        return label
    }()
    
    lazy var howItWorksButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        let attributtedText = NSMutableAttributedString.attributedString(
            L10n.information,
            font: .systemFont(ofSize: 16, weight: .semibold),
            color: .white
        )
        button.setAttributedTitle(attributtedText, for: .normal)
        return button
    }()
    
    lazy var contactSupportButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        let attributtedText = NSMutableAttributedString.attributedString(
            L10n.contact,
            font: .systemFont(ofSize: 16, weight: .semibold),
            color: .white
        )
        button.setAttributedTitle(attributtedText, for: .normal)
        return button
    }()
    
    lazy var copyrightsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        let attributtedText = NSMutableAttributedString.attributedString(
            L10n.copyrights,
            font: .systemFont(ofSize: 16, weight: .semibold),
            color: .white
        )
        button.setAttributedTitle(attributtedText, for: .normal)
        return button
    }()
    
    lazy var unluckProductButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        let attributtedText = NSMutableAttributedString.attributedString(
            "Desbloquear contenido",
            font: .systemFont(ofSize: 16, weight: .semibold),
            color: .white
        )
        button.setAttributedTitle(attributtedText, for: .normal)
        return button
    }()
    
    lazy var termsOfUse: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        let attributtedText = NSMutableAttributedString.attributedString(
            "Terminos de uso",
            font: .systemFont(ofSize: 16, weight: .semibold),
            color: .white
        )
        button.setAttributedTitle(attributtedText, for: .normal)
        return button
    }()
    
    lazy var privacyPolicy: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        let attributtedText = NSMutableAttributedString.attributedString(
            "Política de privacidad",
            font: .systemFont(ofSize: 16, weight: .semibold),
            color: .white
        )
        button.setAttributedTitle(attributtedText, for: .normal)
        return button
    }()
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = R.Base.logo.image
        return image
    }()
    
    
    lazy var powerbrainLogoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = R.Base.powerbrainLogo.image
        return image
    }()
    
    lazy var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.Base.infoImage.image, for: .normal)
        button.isHidden = true
        return button
    }()
    
    lazy var gradientView: CAGradientLayer = {
        let gradientView = CAGradientLayer()
        let topColor = UIColor(red: 127/255, green: 177/255, blue: 72/255, alpha: 1)
        let centerColor1 = UIColor(red: 156/255, green: 190/255, blue: 77/255, alpha: 1)
        let centerColor = UIColor(red: 197/255, green: 208/255, blue: 88/255, alpha: 1)
        let bottomColor = UIColor(red: 215/255, green: 221/255, blue: 86/255, alpha: 1)
        gradientView.colors = [topColor.cgColor, centerColor1.cgColor, centerColor.cgColor, bottomColor.cgColor]
        return gradientView
    }()
    
    // MARK: - Attributes
    
    weak var delegate: SettingsViewControllerDelegate?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.frame = view.bounds
        view.layer.insertSublayer(gradientView, at: 0)
        setupLayout()
        setupActions()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: - Helpers
    
    @objc private func handleHowItWorksSelection(_ sender: UIButton) {
        //delegate?.settingsViewControllerDidSelectHowItWorks()
        if let url = URL(string: "https://www.powerbrain-beats.com/informacion/") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func handleContactSupportSelection(_ sender: UIButton) {
        delegate?.settingsViewControllerDidSelectContact()
    }
    
    @objc private func handleCopyRightsSelection(_ sender: UIButton) {
        delegate?.settingsViewControllerDidSelectCopyrights()
    }
    
    @objc private func handleUnluckProductSelection(_ sender: UIButton) {
        delegate?.settingsViewControllerDidSelectUnluckProduct()
    }
    
    @objc private func handleCloseAction(_ sender: UIButton) {
        delegate?.settingsViewControllerDidSelectClose()
    }
    
    @objc private func handleTermsOfUse(_ sender: UIButton) {
        if let url = URL(string: "https://powerbrain-beats.com/descargoderesponsabilidad/") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func handlePivacy(_ sender: UIButton) {
        if let url = URL(string: "https://powerbrain-beats.com/privacy/") {
            UIApplication.shared.open(url)
        }
    }
    
    private func setupActions() {
        howItWorksButton.addTarget(self, action: #selector(handleHowItWorksSelection(_:)), for: .touchUpInside)
        contactSupportButton.addTarget(self, action: #selector(handleContactSupportSelection(_:)), for: .touchUpInside)
        copyrightsButton.addTarget(self, action: #selector(handleCopyRightsSelection(_:)), for: .touchUpInside)
        unluckProductButton.addTarget(self, action: #selector(handleUnluckProductSelection(_:)), for: .touchUpInside)
        termsOfUse.addTarget(self, action: #selector(self.handleTermsOfUse(_:)), for: .touchUpInside)
        privacyPolicy.addTarget(self, action: #selector(self.handlePivacy(_:)), for: .touchUpInside)
        closebutton.addTarget(self, action: #selector(handleCloseAction(_:)), for: .touchUpInside)
    }
    
    private func setupLayout() {
        
        footerView.addSubview(powerbrainLogoImage)
        footerView.addSubview(infoButton)
        
        view.addSubview(scrollView)
        view.addSubview(footerView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(settingsTitle)
        contentView.addSubview(closebutton)
        contentView.addSubview(howItWorksButton)
        contentView.addSubview(contactSupportButton)
        contentView.addSubview(copyrightsButton)
        contentView.addSubview(unluckProductButton)
        contentView.addSubview(termsOfUse)
        contentView.addSubview(privacyPolicy)
        contentView.addSubview(logoImage)
        
        NSLayoutConstraint.activate([
        
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            
            settingsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            settingsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            closebutton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            closebutton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            closebutton.heightAnchor.constraint(equalToConstant: 24),
            closebutton.widthAnchor.constraint(equalToConstant: 24),
            
            howItWorksButton.topAnchor.constraint(equalTo: settingsTitle.bottomAnchor, constant: 32),
            howItWorksButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            contactSupportButton.topAnchor.constraint(equalTo: howItWorksButton.bottomAnchor, constant: 32),
            contactSupportButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            copyrightsButton.topAnchor.constraint(equalTo: contactSupportButton.bottomAnchor, constant: 32),
            copyrightsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            unluckProductButton.topAnchor.constraint(equalTo: copyrightsButton.bottomAnchor, constant: 32),
            unluckProductButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            termsOfUse.topAnchor.constraint(equalTo: unluckProductButton.bottomAnchor, constant: 32),
            termsOfUse.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            privacyPolicy.topAnchor.constraint(equalTo: termsOfUse.bottomAnchor, constant: 32),
            privacyPolicy.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            logoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            logoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            logoImage.heightAnchor.constraint(equalToConstant: 356),
            
            powerbrainLogoImage.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            powerbrainLogoImage.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            powerbrainLogoImage.heightAnchor.constraint(equalToConstant: 56),
            powerbrainLogoImage.widthAnchor.constraint(equalToConstant: 192),
            
            infoButton.leadingAnchor.constraint(equalTo: powerbrainLogoImage.trailingAnchor, constant: 20),
            infoButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            infoButton.heightAnchor.constraint(equalToConstant: 40),
            infoButton.widthAnchor.constraint(equalToConstant: 40),
            
            footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 72),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
        let contentViewHeithAnchor = contentView.heightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.heightAnchor
        )
        
        contentViewHeithAnchor.priority = .defaultLow
        contentViewHeithAnchor.isActive = true
        
    }
    
}
