//
//  HomeViewControllerDelegate.swift
//  binauralbits
//
//  Created by Byron Chavarría on 6/20/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: class {
    func homeViewControllerDidSelectPlayer(with urlToPlay: String, and songName: String, also image: UIImage, finally numberOfSong: Int)
    func homeViewControllerDidSelectInfoPage(with title: String, and subTitle: String, and numberSong: Int)
    func homeViewControllerDidSelectSettingsPage()
}
