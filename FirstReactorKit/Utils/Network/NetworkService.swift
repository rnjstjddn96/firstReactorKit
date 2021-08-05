//
//  NetworkService.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
import Alamofire
import Combine
import SwiftyBeaver
import SwiftyJSON
import RxSwift
import RxAlamofire

protocol NetworkServiceInterface: AnyObject {
    func request<T>(_ apiBuilder: RequestBuilder, _ decoder: JSONDecoder)
                                        -> Observable<APIResult<T>> where T: Codable
}

final class NetworkService: NetworkServiceInterface {

    func request<T>(_ apiBuilder: RequestBuilder, _ decoder: JSONDecoder = JSONDecoder())
                        -> Observable<APIResult<T>> where T: Codable {
        
        log.debug("""
        REQUEST:\n\(apiBuilder.path)\nHEADER:\n\(apiBuilder.headers ?? HTTPHeaders())
        PARAMETER:\n\(String(describing: apiBuilder.parameters))
        """)
        
        return Observable.create { observer in
//            
//            switch NSObject().currentReachabilityStatus {
//            case .notReachable:
//                observer.onNext(.error(.NOT_CONNECTED, nil))
//            default:
//                break
//            }
            
            let request = AF.request(
                apiBuilder.url,
                method: apiBuilder.method,
                parameters: apiBuilder.parameters,
                headers: apiBuilder.headers,
                interceptor: apiBuilder.interceptor
            )
            .validate()
            .responseData { response in
                switch response.result {
                case let .success(data):
                    
                    log.debug("RESPONSE:\n\(apiBuilder.path)\n\(JSON(data))")
                    
                    //MARK: Connection Success
                    do {
                        let object = try decoder.decode(T.self, from: data)
                        observer.onNext(APIResult(value: object, failed: nil, error: nil, response: response.response!))
                        observer.onCompleted()
                    } catch let error {
                        //MARK: API failed
                        if let failed = try? decoder.decode(APIFailure.self, from: data) {
                            observer.onNext(APIResult(value: nil, failed: failed, error: nil, response: response.response!))
                            observer.onCompleted()
                        } else {
                            //MARK: Decoding Failed
                            observer.onNext(APIResult(value: nil, failed: nil, error: .DECODING(error), response: response.response!))
                            observer.onCompleted()
                        }
                    }
                case let .failure(error):
                    //MARK: Connection Failed
                    log.debug("RESPONSE:\n\(apiBuilder.path)\n\(JSON(error))")
                    observer.onError(APIError.HTTP(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

