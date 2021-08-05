//
//  MpayAPI.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
import Alamofire

enum API {
    case TEST(_ string: String)
    case GET_PROFILE
    case GET_TOKEN(param: [String : Any])
    case GET_ANIMAL
}

extension API: RequestBuilder {
   
//    var request: DataRequest {
//        let url = NetworkConfig.url.appendingPathComponent(path)
//        let request: DataRequest =
//            AF.request(url, method: method,
//                       parameters: parameters,
//                       encoding: self.method == .get ? URLEncoding.default : JSONEncoding.default,
//                       headers: headers)
//        return request
//    }

    
    var url: URL {
        switch self {
        case .TEST(_):
            return NetworkConfig.url.appendingPathComponent(self.path)
        case .GET_PROFILE:
            return NetworkConfig.url.appendingPathComponent(self.path)
        case .GET_TOKEN,
             .GET_ANIMAL:
            return NetworkConfig.animalUrl.appendingPathComponent(self.path)
        }
    }
    
    var encoding: ParameterEncoding? {
        switch self {
        case .TEST(_),
             .GET_PROFILE:
            return URLEncoding.default
        case .GET_TOKEN(_):
            return JSONEncoding.default
        case .GET_ANIMAL:
            return URLEncoding.queryString
        }
    }
    
    var path: String {
        switch self {
        case .TEST(_):
            return "todos"
        case .GET_PROFILE:
            return "appusers/profile"
        case .GET_TOKEN(_):
            return "/v2/oauth2/token"
        case .GET_ANIMAL:
            return "/v2/animals"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .TEST(_),
             .GET_PROFILE,
             .GET_ANIMAL:
            return .get
        case .GET_TOKEN(_):
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        var headers = HTTPHeaders()
        switch self {
            case .TEST:
                headers["Content-Type"] = "Application/json"
                return headers
            case .GET_PROFILE:
                headers["X-Auth-Token"] = "svt9CJSguQBTyxGj2ZxMdwdbIHNg/4sA5HCVYZzpVjxSjasnV3+AuqfJ4Ohs/cEPdysaC+9ioR/TJ4K+TQhw1fjBF78SFZ4UDWCqYHKiKgpR1k7nRTM9tX0wmrePxMsJEFc3pp2Svh/38OySEMlyIlidHz7hdjLOC4RZH/NAaQfYuBBqC56YCHmXVytY5S5gIkSX8c4OBx7ZSQJa09V1IvEfQtPLZ1X47Uf6LdneCSl8anlxPSNnaaA5P3SntGEjHg81k1m6OoCnObMVpywl4AA4XstB6Sf1xF7nEVtHpumYvUSheJ5WHiiNHd5cK0b5LrfUn1xqt/aHUVksh/yOTuHrq7CVKXKv8JvF1+J1fddiGZyMiClaIwg2uSyr620wTEbMt44xJH91meSJBsE9EEk6eA8Sy6S3eXPARfEx8XPSDGPQm+fr3x/Ddjx3I/cbw5mJR2ylIVo7nu6vEadOfbh815Nq9k+SsE0fOdiMF9p9rdwrmyV5DwC2xT7pG0Vz3CgFZPcHzjAfw0iP0KW/tcntFjjhdT1FEsBBaS0pCXlAqiv8B7zJB9zyZCCDdw7XnUXl1XmO501d2eyjZ8209L37Wf+/u440lTFrV5QhREQPV8BwOMJj3Mq9pWjNmmy/iwE7m81hfZbdZg/UUgcC9NAkRYpnMrcL2BrNhxwznZI="
                return headers
            case .GET_TOKEN(_),
                 .GET_ANIMAL:
                return nil
        }
    }
    
    var parameters: Parameters? {
        var parameters = Parameters()
        switch self {
        case .TEST(_):
            return nil
        case .GET_PROFILE:
            return nil
        case .GET_TOKEN(param: let param):
            parameters = param
            return parameters
        case .GET_ANIMAL:
            return nil
        }
    }
    
    var interceptor: RequestInterceptor? {
        let customInterceptor = CustomInterceptor()
        switch self {
        case .TEST(_),
             .GET_PROFILE,
             .GET_TOKEN(_):
            return nil
        case .GET_ANIMAL:
            return customInterceptor
        }
    }
    
    var multipartData: Multiparts? {
        var multipartItem = [String: Data?]()
        return multipartItem
    }
}
