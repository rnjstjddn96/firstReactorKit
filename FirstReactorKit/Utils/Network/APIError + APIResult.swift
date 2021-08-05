//
//  APIError.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
import Alamofire

enum APIError: Error {
    case HTTP(AFError)
    case DECODING(Error)
    case UNKNOWN
    case NOT_CONNECTED
    
    var reason: String {
        switch self {
        case .HTTP(let httpError):
            return "\(httpError)"
        case .DECODING(let error):
            return "디코딩 에러: \(error)"
        case .NOT_CONNECTED:
            return "인터넷 연결 후 사용해주세요"
        default:
            return "UNKNOWN"
        }
    }
}

struct APIFailure: Codable {
    var resultCode: Int?
    var resultMessage: String?
    var statusCode: Int?
    var message: String?
    var name: String?
    var detail: String?
}

enum NetworkError: Int, Error {
  case badRequest                       = 400
  case authenticationFailed             = 401
  case notFoundException                = 404
  case contentLengthError               = 413
  case quotaExceeded                    = 429
  case systemError                      = 500
  case endpointError                    = 503
  case timeout                          = 504
}

struct APIResult<T> {
    let value: T?
    let failed: APIFailure?
    let error: APIError?
    let response: URLResponse
}
