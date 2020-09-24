//
//  HomeViewModel.swift
//  binauralbits
//
//  Created by Byron Chavarría on 5/4/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import RxSwift
import Moya

final class HomeViewModel {
    
    // MARK: - Service
    
    private let defaultService: DefaultService
    
    // MARK: - LifeCycle
    
    init(defaultService: DefaultService) {
        self.defaultService = defaultService
    }
    
    func getSongs() -> Observable<[SongResponseModel]> {
        return defaultService.getSongs().asObservable()
    }
    
    func getReceiptStatus(with data: String) -> Single<ReceiptResponseModel> {
        return defaultService.getReceiptStatus(with: data)
            .asObservable()
            .asSingle()
    }
    
}
