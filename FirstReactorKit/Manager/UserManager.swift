//
//  UserManager.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/22.
//

import Foundation
import UIKit
import RxSwift

class UserManager {
    static let current = UserManager()
    var user = BehaviorSubject<User?>(value: nil)

    private init() { }
    
    func updateUser(user: User) {
        self.user.onNext(user)
    }
    
    func deleteUser() {
        self.user.onNext(nil)
    }
}
