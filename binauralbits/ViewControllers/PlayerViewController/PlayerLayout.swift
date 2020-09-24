//
//  PlayerLayout.swift
//  binauralbits
//
//  Created by Byron Chavarría on 6/20/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit

extension PlayerViewController {
    func setupLayout() {
        progressBarView.progress = 0.0
        buttonsView.addArrangedSubview(repeatButton)
        buttonsView.addArrangedSubview(backButton)
        buttonsView.addArrangedSubview(playButton)
        buttonsView.addArrangedSubview(stopButton)
        
        footerView.addSubview(powerbrainLogoImage)
        footerView.addSubview(infoImage)
        
        view.addSubview(scrollView)
        view.addSubview(footerView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(principalImage)
        contentView.addSubview(backgroundImage)
        contentView.addSubview(progressBarView)
        contentView.addSubview(buttonsView)
        contentView.addSubview(volumenImage)
        contentView.addSubview(volumeView)
        contentView.addSubview(downloadButton)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
            principalImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            principalImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            principalImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            principalImage.heightAnchor.constraint(equalToConstant: 203),
            
            progressBarView.topAnchor.constraint(equalTo: principalImage.bottomAnchor, constant: 72),
            progressBarView.heightAnchor.constraint(equalToConstant: 1),
            progressBarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            progressBarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            repeatButton.heightAnchor.constraint(equalToConstant: 48),
            
            buttonsView.topAnchor.constraint(equalTo: progressBarView.bottomAnchor, constant: 32),
            buttonsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 64),
            buttonsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -64),
            
            volumenImage.topAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: 32),
            volumenImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            volumenImage.heightAnchor.constraint(equalToConstant: 32),
            volumenImage.widthAnchor.constraint(equalToConstant: 32),
            
            volumeView.topAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: 32),
            volumeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
            volumeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            volumeView.heightAnchor.constraint(equalToConstant: 24),
            
            downloadButton.topAnchor.constraint(equalTo: volumeView.bottomAnchor, constant: 16),
            downloadButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 160),
            
            backgroundImage.topAnchor.constraint(equalTo: principalImage.bottomAnchor, constant: 56),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            backgroundImage.heightAnchor.constraint(equalToConstant: 356),
            
            powerbrainLogoImage.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            powerbrainLogoImage.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            powerbrainLogoImage.heightAnchor.constraint(equalToConstant: 56),
            powerbrainLogoImage.widthAnchor.constraint(equalToConstant: 192),
            
            infoImage.leadingAnchor.constraint(equalTo: powerbrainLogoImage.trailingAnchor, constant: 20),
            infoImage.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            infoImage.heightAnchor.constraint(equalToConstant: 40),
            infoImage.widthAnchor.constraint(equalToConstant: 40),
            
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
