//
//  Token.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/03.
//

import Foundation

struct Token: Codable {
    var token_type: String?
    var expires_in: Int?
    var access_token: String?
    
    enum CodingKeys: String, CodingKey {
        case token_type = "token_type"
        case expires_in = "expires_in"
        case access_token = "access_token"
    }
}
