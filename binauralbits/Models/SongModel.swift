//
//  SongModel.swift
//  binauralbits
//
//  Created by Byron Chavarría on 6/20/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import RealmSwift

class SongModel: Object {
    @objc var songId: Int = 0
    @objc var songName: String = ""
    @objc var songUrl: String = ""
}
