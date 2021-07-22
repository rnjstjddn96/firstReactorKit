//
//  UserManager.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UserManager {
    static let current = UserManager()
    var user = BehaviorRelay<User?>(value: nil)

    private init() { }
}
