//
//  MpayService.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
import Combine
import Alamofire
import UIKit
import RxSwift

protocol APIService {
    var session: NetworkService { get }
}

extension APIService {
    func getTodos() -> Observable<APIResult<[Todo]>> {
        return session.request(API.TEST("todos"))
    }
    
    func getProfile() -> Observable<APIResult<User>> {
        return session.request(API.GET_PROFILE)
    }
}
