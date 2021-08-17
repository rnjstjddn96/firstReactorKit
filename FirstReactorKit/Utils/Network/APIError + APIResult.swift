//
//  APIError.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
import Alamofire

enum APIError: Error {
    case failure(APIFailure)
    case error(AFError)
    case decoding(Error)
    case unknown
    
    var reason: String {
        switch self {
        case .failure(let httpError):
            return httpError.message ?? ""
        case .error(let error):
            if error.isSessionTaskError {
                return "네트워크 상태가 원활하지 않습니다."
            } else {
                return error.localizedDescription
            }
        case .decoding(let error):
            return "JSON DECODING ERROR OCCURED\n" + error.localizedDescription
        case .unknown:
            return "UNKNOWN ERROR OCCURED"
        }
    }
}

struct APIFailure: Codable {
    var resultCode: Int?
    var resultMessage: String?
    var statusCode: Int?
    var message: String?
    var name: String?
}

struct APIResult<T> {
    let value: T?
    let failed: APIFailure?
    let error: APIError?
    let response: URLResponse
}
