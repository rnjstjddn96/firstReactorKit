//
//  Todo.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/21.
//

import Foundation
import UIKit

struct Todo: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var completed: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
        case completed = "completed"
    }
}




