//
//  MpayAPI.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
import Alamofire

enum APIs {
    case TEST(_ string: String)
    case GET_PROFILE
    case GET_CARD
}

extension APIs: RequestBuilder {

    var url: URL {
        switch self {
        case .TEST(_):
            return URL(string: "https://jsonplaceholder.typicode.com/")!.appendingPathComponent(self.path)
        default:
            return NetworkConfig.url.appendingPathComponent(self.path)
        }
    }
    
    var path: String {
        switch self {
        case .TEST(let test):
            return test
        case .GET_PROFILE:
            return "appusers/profile"
        case .GET_CARD:
            return "cards"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .TEST(_):
            return .get
        case .GET_PROFILE:
            return .get
        case .GET_CARD:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        switch self {
            case .TEST:
                headers["Content-Type"] = "Application/json"
                return headers
            default:
                headers["Content-Type"] = "Application/json"
                headers["X-Auth-Token"] =  prefs.string(forKey: PrefsEnum.X_AUTH_TOKEN.rawValue)
                
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
        case .GET_CARD:
            return nil
        }
    }
    
    var multipartData: Multiparts? {
        var multipartItem = [String: Data?]()
        return multipartItem
    }
}
