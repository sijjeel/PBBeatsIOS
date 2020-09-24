//
//  PlayerCollectionViewCell.swift
//  binauralbits
//
//  Created by Byron Chavarría on 4/30/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import UIKit
import Reusable

final class PlayerCollectionViewCell: UICollectionViewCell, NibReusable {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
