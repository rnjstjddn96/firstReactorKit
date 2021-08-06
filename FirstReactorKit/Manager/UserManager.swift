//
//  UserManager.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/22.
//

import Foundation
import UIKit
import RxSwift

enum Authorization: Equatable {
    case AUTHORIZED(user: User)
    case UNAUTHORIZED
}

class UserManager {
    static let current = UserManager()
    var authoriation = BehaviorSubject<Authorization>(value: .UNAUTHORIZED)

    private init() { }
    
    func authorize(user: User) {
        self.authoriation.onNext(.AUTHORIZED(user: user))
    }
    
    func deleteUser() {
        self.authoriation.onNext(.UNAUTHORIZED)
    }
}
