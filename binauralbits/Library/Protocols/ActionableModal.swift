//
//  ActionableModal.swift
//  binauralbits
//
//  Created by Byron Chavarría on 5/4/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import Foundation

protocol ActionableModal {
    var title: String { get }
    var subtitle: String { get }
    var actionTitle: String { get }
    var isDismissable: Bool { get }
    var headingIsHidden: Bool { get }
    var headingTitle: String? { get }
}
