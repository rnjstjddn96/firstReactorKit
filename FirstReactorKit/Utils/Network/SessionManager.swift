//
//  SessionManager.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/17.
//

import Foundation
import Alamofire

class SessionManager {
    static let shared: SessionManager = SessionManager()
    private let session: Session?
    
    private init() {
        let urlSessionConfiguration = URLSessionConfiguration.af.default
        urlSessionConfiguration.timeoutIntervalForRequest = 20
        urlSessionConfiguration.timeoutIntervalForResource = 20
        self.session = Session(configuration: urlSessionConfiguration)
    }
    
    func getSession() -> Session? {
        return self.session
    }
}
