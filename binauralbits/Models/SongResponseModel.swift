//
//  SongResponseModel.swift
//  binauralbits
//
//  Created by Byron Chavarría on 5/4/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import Foundation

class SongResponseModel: Decodable {
    let songId: Int?
    let songName: String?
    let songUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case songId = "songId"
        case songName = "songName"
        case songUrl = "uri"
    }
}
