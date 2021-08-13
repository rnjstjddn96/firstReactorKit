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
        return session.request(APIs.TEST("todos"))
    }
    
    func getProfile() -> Observable<APIResult<User>> {
        return session.request(APIs.GET_PROFILE)
    }
    
    func getCards() -> Observable<APIResult<[CardAccountInfo]>> {
        return session.request(APIs.GET_CARD)
    }
}
