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
        NetworkConfig.url.appendingPathComponent(self.path)
    }
    
    var path: String {
        switch self {
        case .TEST(_):
            return "todos"
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
                headers["X-Auth-Token"] = "T2h9fS8tgajxOG+fjAxB4QIJECZ0GrDVCcucJO4G/xNbdQaqBgP8f2zgN4bGOAsRqrVjW5MayNV8M3Ifva9vaO/aWXXinGs6zs9I3Zt0nOayQSAT02+jJby03WyyZyP3Ewib0/OtncAESQGNhb0bnHj+TkeP8BFyt+XhdYN2MxFaq13+WjTNQaNW6rguwdtlOHWnTqTZk7M30HyKWFJ6cXml8cxHGyswmxP8UXU567luvN3VOMSRA/K/eAywRUqIgO/cGdjIP1NABfPzDuXJUKHmDO5/4U002iP6xoGHubhCyC5Jjo+GBencMHkj58nC9WzHsiqkpcHYQwQtjRyEk0yWjnxIgg3K2TEzm1ss7IPXQYZlMvynpDiJwMMGG7oIOhdD8yaZFTFetxAp08+x7grKazLnqxNNwLuZBY3UXkoSXa1cGrO8U7Fslke4aqHsk0FlPEsAOH22R8AoSy1Dup/L6saorqIJ/MaNX25SiWgss/Sf/mq/GjJT93owOe4OQVjv7dXlb0ixJhOuoRUeTPQyInQUzV7L6oi2gK1H5AC4Bv0J9eDpGop6F19dZcGcCvQHJqJzv1uy7vL/N0wIQQD8oODW6UwV+HBglj1X70ac89Ca/B7XVxchirBcFPLsT88dNlxgDkqP0cDr8yAbEUtlUuk2bIyWyGgoMXXGyU8="
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
