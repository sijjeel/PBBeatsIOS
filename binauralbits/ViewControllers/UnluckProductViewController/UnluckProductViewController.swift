//
//  UnluckProductViewController.swift
//  binauralbits
//
//  Created by Byron Chavarría on 7/27/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit
import StoreKit
import RealmSwift
import SwiftKeychainWrapper

final class UnluckProductViewController: UIViewController {
    
    // MARK: - Components
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var inAppPurchaseIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.Images.inAppPurchaseIcon.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleSubscription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var detailSubscription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 56)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var purchaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Comprar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var restoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.setTitle("Restaurar compra", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Cancelar", for: .normal)
        return button
    }()
    
    // MARK: - Attributes
    
    weak var delegate: UnluckProductViewControllerDelegate?
    var product: SKProduct?
    var viewModel = UnluckProductViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.blue.color
        setupLayout()
        setupActions()
        viewModel.delegate = self
        getProducts()
    }
    
    // MARK: - Methods
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(inAppPurchaseIcon)
        contentView.addSubview(titleSubscription)
        contentView.addSubview(detailSubscription)
        contentView.addSubview(priceLabel)
        contentView.addSubview(purchaseButton)
        contentView.addSubview(restoreButton)
        contentView.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            
            inAppPurchaseIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            inAppPurchaseIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            inAppPurchaseIcon.widthAnchor.constraint(equalToConstant: 164),
            inAppPurchaseIcon.heightAnchor.constraint(equalToConstant: 164),
            
            titleSubscription.topAnchor.constraint(equalTo: inAppPurchaseIcon.bottomAnchor, constant: 64),
            titleSubscription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleSubscription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            detailSubscription.topAnchor.constraint(equalTo: titleSubscription.bottomAnchor, constant: 32),
            detailSubscription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailSubscription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            priceLabel.topAnchor.constraint(equalTo: detailSubscription.bottomAnchor, constant: 32),
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            purchaseButton.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: priceLabel.bottomAnchor, multiplier: 0.50),
            purchaseButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            purchaseButton.bottomAnchor.constraint(equalTo: restoreButton.topAnchor, constant: -16),
            purchaseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            purchaseButton.heightAnchor.constraint(equalToConstant: 50),
            
            restoreButton.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: purchaseButton.bottomAnchor, multiplier: 0.50),
            restoreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            restoreButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -16),
            restoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            restoreButton.heightAnchor.constraint(equalToConstant: 50),
            
            cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            cancelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        let contentViewHeightContraint = contentView.heightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.heightAnchor
        )
        contentViewHeightContraint.priority = .defaultLow
        contentViewHeightContraint.isActive = true
    }
    
    private func setupActions() {
        purchaseButton.addTarget(
            self,
            action: #selector(didTapMakePurchase(_:)),
            for: .touchUpInside
        )
        
        restoreButton.addTarget(
            self,
            action: #selector(didTapRestorePurchase(_:)),
            for: .touchUpInside
        )
        
        cancelButton.addTarget(
            self,
            action: #selector(didTapCancel(_:)),
            for: .touchUpInside
        )
    }
    
    func getProducts() {
        IAPManager.shared.getProducts { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self.dismiss(animated: true, completion: {
                        self.product = products[0]
                        let price = (self.product?.price ?? 0) as NSNumber
                        
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .currency
                        formatter.string(from: price)
                        
                        formatter.locale = self.product?.priceLocale
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: {
                                self.priceLabel.text = formatter.string(from: price)
                                self.titleSubscription.text = self.product?.localizedTitle
                                self.detailSubscription.text = self.product?.localizedDescription
                            })
                        }
                    })
                case .failure(let error):
                    self.dismiss(animated: true, completion: {
                        self.showAlertController(with: L10n.appName, and: error.errorDescription ?? "")
                    })
                }
            }
        }
    }
    
    @objc private func didTapCancel(_ sender: UIButton) {
        delegate?.unluckProductViewControllerDidSelectCancel()
    }
    
    @objc private func didTapRestorePurchase(_ sender: UIButton) {
        viewModel.restorePurchases()
    }
    
    @objc private func didTapMakePurchase(_ sender: UIButton) {
        guard let product = product else {
            showAlertController(with: L10n.appName, and: "No hay ningún producto disponible")
            return
        }
        showAlert(for: product)
    }
    
    func showAlert(for product: SKProduct) {
        //        guard let price = IAPManager.shared.getPriceFormatted(for: product) else { return }
        let alertController = UIAlertController(title: product.localizedTitle,
                                                message: product.localizedDescription,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: product.localizedDescription, style: .default, handler: { (_) in
            
            if !self.viewModel.purchase(product: product) {
                self.showAlertController(with: L10n.appName, and: "In-App Purchases are not allowed in this device.")
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func showLoading() {
        let alert = UIAlertController(title: nil, message: L10n.loading, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 60, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertController(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: L10n.ok, style: .default) { (actions: UIAlertAction) in
            alert.dismiss(animated: true, completion: {
                self.delegate?.unluckProductViewControllerDidSelectCancel()
            })
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UnluckProductViewController: UnluckProductViewModelDelegate {
    func showIAPRelatedError(_ error: Error) {
        self.showAlertController(with: L10n.appName, and: error.localizedDescription)
    }
    
    func didFinishRestoringPurchasesWithZeroProducts() {
        self.showAlertController(with: L10n.appName, and: "There are no purchased items to restore.")
    }
    
    func didFinishRestoringPurchasedProducts() {
        self.showAlertController(with: L10n.appName, and: "Purchase have been restored!")
        KeychainWrapper.standard.set(true, forKey: K.premiumUserKey)
    }
    
    func successPurchase() {
        self.showAlertController(with: L10n.appName, and: "Purchase was successfull")
        KeychainWrapper.standard.set(true, forKey: K.premiumUserKey)
        
    }
}
