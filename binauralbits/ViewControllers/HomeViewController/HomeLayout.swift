//
//  HomeLayout.swift
//  binauralbits
//
//  Created by Byron Chavarría on 6/20/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit

extension HomeViewController {
    func setupLayout() {
        
        firstStackView.addArrangedSubview(first)
        firstStackView.addArrangedSubview(second)
        
        secondStackView.addArrangedSubview(third)
        secondStackView.addArrangedSubview(fourth)
        
        footerView.addSubview(powerbrainLogoImage)
        footerView.addSubview(infoButton)
        
        view.addSubview(scrollView)
        view.addSubview(footerView)
        scrollView.addSubview(contentView)
        contentView.addSubview(firstStackView)
        contentView.addSubview(secondStackView)
        contentView.addSubview(fifth)
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
            
            firstStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 56),
            firstStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            firstStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            firstStackView.heightAnchor.constraint(equalToConstant: 96),
            
            secondStackView.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 32),
            secondStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            secondStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            secondStackView.heightAnchor.constraint(equalToConstant: 96),
            
            fifth.topAnchor.constraint(equalTo: secondStackView.bottomAnchor, constant: 32),
            fifth.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            fifth.widthAnchor.constraint(equalToConstant: 171),
            fifth.heightAnchor.constraint(equalToConstant: 96),
            
            logoImage.topAnchor.constraint(equalTo: fifth.bottomAnchor, constant: -32),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            logoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
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
        
        let contentHeihtContraint = contentView.heightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.heightAnchor
        )
        contentHeihtContraint.priority = .defaultLow
        contentHeihtContraint.isActive = true
    }
}

