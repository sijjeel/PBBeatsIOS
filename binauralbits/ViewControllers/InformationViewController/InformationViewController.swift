//
//  InformationViewController.swift
//  binauralbits
//
//  Created by Byron Chavarría on 3/7/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit

final class InformationViewController: UIViewController {
    
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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var gradientView: CAGradientLayer = {
        let gradientView = CAGradientLayer()
        return gradientView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Attributes
    
    var hideCloseButton: Bool = false
    weak var delegate: InformationViewControllerDelegate?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.frame = view.bounds
        view.layer.insertSublayer(gradientView, at: 0)
        setupLayout()
        setupActions()
        closebutton.isHidden = hideCloseButton
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: - Helpers
    
    @objc private func handleCloseAction() {
        delegate?.informationViewControllerDidSelectBack()
    }
    
    private func setupActions(){
        closebutton.addTarget(self, action: #selector(handleCloseAction), for: .touchUpInside)
    }
    
    private func setupLayout() {
        
        view.addSubview(closebutton)
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            
            closebutton.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            closebutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            closebutton.heightAnchor.constraint(equalToConstant: 24),
            closebutton.widthAnchor.constraint(equalToConstant: 24),
            
            scrollView.topAnchor.constraint(equalTo: closebutton.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 96),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        let contentHeihtContraint = contentView.heightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.heightAnchor
        )
        contentHeihtContraint.priority = .defaultLow
        contentHeihtContraint.isActive = true
        
    }
    
    
    func setupLabel(with title: String, and info: String) {
        let attributedTitleText = NSMutableAttributedString.attributedString(
            title,
            font: .boldSystemFont(ofSize: 18),
            color: .white
        )
        
        let attributedInfoText = NSMutableAttributedString.attributedString(
            info,
            font: .systemFont(ofSize: 16),
            color: .white
        )
        
        titleLabel.numberOfLines = 0
            
        titleLabel.attributedText = attributedTitleText
        label.numberOfLines = 0
            
        label.attributedText = attributedInfoText
    }
}
