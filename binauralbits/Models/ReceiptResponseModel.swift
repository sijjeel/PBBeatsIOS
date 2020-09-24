//
//  ReceiptResponseModel.swift
//  binauralbits
//
//  Created by Byron Chavarría on 8/1/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import Foundation

struct ReceiptResponseModel: Codable {
//    let environment: String?
//    let isretryable: Bool?
    //let latest_receipt: Data?
    let status: Int
    
    enum CodingKeys: String, CodingKey {
        //case environment = "environment"
        //case isretryable = "is-retryable"
        //case latest_receipt = "latest_receipt"
        case status = "status"
    }
}
