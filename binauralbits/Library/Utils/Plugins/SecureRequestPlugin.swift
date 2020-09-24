//
//  SecureRequestPlugin.swift
//  binauralbits
//
//  Created by Byron Chavarría on 5/4/20.
//  Copyright © 2020 Powerbraintuner. All rights reserved.
//

import Moya

final class SecureRequestPlugin: PluginType {
    
    // MARK: - Attributes
    
    // MARK: - LifeCycle
    
    // MARK: - Prepare Request
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        let isSecureMethod = K.MoyaDefaults.secureMethods.contains(target.method)
        guard isSecureMethod else { return request }
        
        switch target.task {
        case let .requestParameters(parameters, _):
            var secureRequest = request
            #if DEBUG
//                DeviceLogger.debug(parameters)
            #endif
            
            do {
                secureRequest.httpBody = try JSONSerialization.data(
                    withJSONObject: parameters,
                    options: .prettyPrinted
                )
                
                return secureRequest
            } catch {}
            
        default: break
        }
        return request
    }
    
    // MARK: - Prepare Response
    
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        switch result {
        case let .success(response):
            do {
//                let responseModel = response
//
//                let plainMessage = result
                let jsonData = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                
                #if DEBUG
//                    DeviceLogger.debug(plainRequestInfo)
                #endif
                
                
                let plainRequestData = try JSONSerialization.data(
                    withJSONObject: jsonData,
                    options: []
                )
                
                let plainResponse = Response(
                    statusCode: response.statusCode,
                    data: plainRequestData,
                    request: response.request,
                    response: response.response
                )
                return .success(plainResponse)
                
            } catch {}
            
        default: break
        }
        return result
    }
}


