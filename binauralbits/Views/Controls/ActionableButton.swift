//
//  ActionableButton.swift
//  binauralbits
//
//  Created by Byron Chavarría on 5/16/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit

final class ActionableButton: UIButton {
    
    // MARK: - Components
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
       let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Attributes
    
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    var isAnimating: Bool {
        return activityIndicator.isAnimating
    }
    
    func startAnimating() {
        isEnabled = false
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        isEnabled = true
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Helpers
    
    private func addActivityIndicator() {
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setup() {
        
        layer.cornerRadius = 18
        layer.masksToBounds = true
        addActivityIndicator()
    }
}

