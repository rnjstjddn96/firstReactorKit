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
                headers["X-Auth-Token"] = "kBol2fLUZUebdWbCfsPgHjFm37DRvXlqI+J0VvOjUJItnLsdva7bfjwoWsnPqKfozkR8MXoO3QUtzW4GNxbf4yjbrxqeJuCa5x0LPCSmLFPn4zFZk7T6zkjxZEMlkn8rRMcvwJqb/ilDpsKuiPSNJ29pjvY4pkd9gv6bC70+4kecXadjDBjau3myCcD8F/eUl8TYb96aatco8lpe/7RWpX/kmRdfY8DpClmmX+uGZDtQmAm/FmIrm1wFjaZnDCilxmOp/r15uMCutbR1WX8dS6iQDn/xrVcIyv5ePoAiZClVYSawliGQxC8WnMNYX3+/2TWMrVD+ykxoKvv4wAMeMQstLkkaE6aV/P3IPKetFGyvKcZX4ToX8TtSDSKu5W6Wqj9z5qEMUlfQQE31wrtfCgTLQOfk/jGQnj8QkcsAN8SGDwthfBt8WMvt9rM0n+bZcLb0X7DbgoRi2+BC6d7GvxmXBBS5G3A/uM40HSgLUIVJ7/72RjRG/bEzyy7C5Di5dA227T8ETx4VyKiXALzbdnc0vlqbTinYpm5ZGnjYAc2Sd4FpL0I7eyPhFkvqftkUrMFRLJiVs0ekvEMqIcOD8tLVBSK9wVK98mQeDo9eYrJAUInZclkTByvC9PokMNZNuP2LemEMi99t7YXg9LlvUYrNsnjfSJxTd0s4mDH10kU="
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
