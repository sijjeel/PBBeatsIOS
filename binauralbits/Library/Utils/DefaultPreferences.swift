//
//  DefaultPreferences.swift
//  binauralbits
//
//  Created by Byron Chavarría on 5/4/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import Foundation

final class DefaultPreferences {
    
    static let current = DefaultPreferences()
    
    var lstOfSongs: [SongResponseModel]?
    var urlSong: URL?
    var isFromPlayer: Bool = false
    var defaultValue: String = "QmluYXVyYWxCaXRzUEJCUA=="
}
