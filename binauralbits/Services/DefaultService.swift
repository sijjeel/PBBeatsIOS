//
//  DefaultService.swift
//  binauralbits
//
//  Created by Byron Chavarría on 5/4/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import Moya
import RxSwift

final class DefaultService {
    
    private let provider = MoyaProvider<DefaultProvider>(
        plugins: K.MoyaDefaults.plugins
    )
    
    func getSongs() -> Observable<[SongResponseModel]> {
        let request = provider.rx
            .request(.songs)
            .filterSuccessfulStatusCodes()
            .map([SongResponseModel].self)
            .asObservable()
        
        return request
    }
    
    func getReceiptStatus(with data: String) -> Single<ReceiptResponseModel> {
        let request = provider.rx
            .request(.receipt(data: data))
            .filterSuccessfulStatusCodes()
            .map(ReceiptResponseModel.self)
            .asObservable()
            .asSingle()
        return request
    }
    
}
