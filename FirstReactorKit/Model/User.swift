//
//  User.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/19.
//

import Foundation
import UIKit

struct User: Codable, Equatable {
    var name: String
    var phoneNumber: String
    var birthday: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case phoneNumber = "phoneNumber"
        case birthday = "birthday"
    }
}
