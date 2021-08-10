//
//  RequestBuilder.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
import Alamofire

protocol RequestBuilder {
    typealias Parameters = [String: Any]
    typealias Multiparts = [String: Data?]
//    var request: DataRequest { get }
    var url: URL { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var multipartData: Multiparts? { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: ParameterEncoding? { get }
    var interceptor: RequestInterceptor? { get }
    var timeoutInterval: Double? { get }
}
