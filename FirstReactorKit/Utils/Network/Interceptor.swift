//
//  Interceptor.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/17.
//

import Foundation
import Alamofire

class MpayInterceptor: RequestInterceptor {
    let RETRY_LIMIT = 3
    
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < RETRY_LIMIT else {
            completion(.doNotRetry)
            return
        }
        
        completion(.retry)
    }
}
