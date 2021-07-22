//
//  NetworkConfig.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
struct NetworkConfig {
    static let baseUrl = "https://dev.miraeassetpay.kr/"
    static let API_SERVICE = "api"
    static let API_VERSION = "v2"
    
    static let url: URL = URL(string: "\(baseUrl)\(API_SERVICE)")!
}

