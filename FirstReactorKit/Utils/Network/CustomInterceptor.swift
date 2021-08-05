//
//  CustomInterceptor.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/03.
//

import Foundation
import Alamofire

class CustomInterceptor: RequestInterceptor {
    let retryLimit = 3
    let authorize = "https://api.petfinder.com/v2/oauth2/token"
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        guard let token = UserDefaultsManager.shared.getToken() else {
            // 토큰이 없을 때 바로 retry로 이동
            completion(.success(urlRequest))
            return
        }
        
        var bearerToken = ""
        if cnt % 2 == 0 {
            bearerToken = "Bearer \(token)"
        } else {
            cnt += 1
            bearerToken = "Bearer \(token)000000"
        }
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        print("\nadapted; token added to the header field is: \(bearerToken)\n")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }
        print("\nretried; retry count: \(request.retryCount)\n")
        refreshToken { isSuccess in
            isSuccess ? completion(.retry) : completion(.doNotRetry)
        }
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        guard let apiKey = UserDefaultsManager.shared.getUserCredentials().apiKey,
            let secretKey = UserDefaultsManager.shared.getUserCredentials().secretKey else { return }
        
        let parameters = ["grant_type": "client_credentials", "client_id": apiKey, "client_secret": secretKey]
        
        AF.request(authorize, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if let data = response.data, let token = (try? JSONSerialization.jsonObject(with: data, options: [])
                as? [String: Any])?["access_token"] as? String {
                UserDefaultsManager.shared.setToken(token: token)
                print("\nRefresh token completed successfully. New token is: \(token)\n")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
