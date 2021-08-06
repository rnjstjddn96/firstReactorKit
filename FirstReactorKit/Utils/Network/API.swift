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
}

extension API: RequestBuilder {

    var url: URL {
        switch self {
        case .TEST(_):
            return URL(string: "https://jsonplaceholder.typicode.com/")!.appendingPathComponent(self.path)
        case .GET_PROFILE:
            return NetworkConfig.url.appendingPathComponent(self.path)
        }
    }
    
    var path: String {
        switch self {
        case .TEST(let test):
            return test
        case .GET_PROFILE:
            return "appusers/profile"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .TEST(_):
            return .get
        case .GET_PROFILE:
            return .get
        
        }
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        switch self {
            case .TEST:
                headers["Content-Type"] = "Application/json"
                return headers
            case .GET_PROFILE:
                headers["Content-Type"] = "Application/json"
                headers["X-Auth-Token"] = "svt9CJSguQBTyxGj2ZxMdwdbIHNg/4sA5HCVYZzpVjxSjasnV3+AuqfJ4Ohs/cEPdysaC+9ioR/TJ4K+TQhw1fjBF78SFZ4UDWCqYHKiKgpR1k7nRTM9tX0wmrePxMsJEFc3pp2Svh/38OySEMlyIlidHz7hdjLOC4RZH/NAaQfYuBBqC56YCHmXVytY5S5gIkSX8c4OBx7ZSQJa09V1IvEfQtPLZ1X47Uf6LdneCSl8anlxPSNnaaA5P3SntGEjHg81k1m6OoCnObMVpywl4AA4XstB6Sf1xF7nEVtHpumYvUSheJ5WHiiNHd5cK0b5LrfUn1xqt/aHUVksh/yOTuHrq7CVKXKv8JvF1+J1fddiGZyMiClaIwg2uSyr620wTEbMt44xJH91meSJBsE9EEk6eA8Sy6S3eXPARfEx8XPSDGPQm+fr3x/Ddjx3I/cbw5mJR2ylIVo7nu6vEadOfbh815Nq9k+SsE0fOdiMF9p9rdwrmyV5DwC2xT7pG0Vz3CgFZPcHzjAfw0iP0KW/tcntFjjhdT1FEsBBaS0pCXlAqiv8B7zJB9zyZCCDdw7XnUXl1XmO501d2eyjZ8209L37Wf+/u440lTFrV5QhREQPV8BwOMJj3Mq9pWjNmmy/iwE7m81hfZbdZg/UUgcC9NAkRYpnMrcL2BrNhxwznZI="
                return headers
        }
    }
    
    var parameters: Parameters? {
        var parameters = Parameters()
        switch self {
        case .TEST(_):
            return nil
        case .GET_PROFILE:
            return nil
        }
    }
    
    var multipartData: Multiparts? {
        var multipartItem = [String: Data?]()
        return multipartItem
    }
}
