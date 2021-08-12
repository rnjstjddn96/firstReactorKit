//
//  SplashReactor.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/19.
//

import Foundation
import ReactorKit
import Alamofire

enum ReactorError: Error {
    case UNKNOWN
    case NETWORK(failure: APIFailure?, error: APIError?)
    
    var desc: String {
        switch self {
        case .UNKNOWN:
            return "알 수 없는 오류가 발생했습니다."
        case .NETWORK(_,_):
            return "네트워크 오류가 발생했습니다."
        }
    }
}

class SplashReactor: Reactor, APIService {
    var session = NetworkService()
    var initialState: State = State()
    
    enum Action {
        case showLogo
        case errorOccered(type: ReactorError)
        case getUser
        case route(to: UIViewController)
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setLogo(Bool)
        case setUser(user: User)
        case setError(error: ReactorError)
        case setAlert(message: String)
        case setDestination(to: UIViewController)
    }
    
    struct State {
        var isLoading: Bool = false
        var logoShown: Bool = false
        var user: User?
        var failure: APIFailure?
        var error: Error?
        var message: String?
        var destination: UIViewController?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .showLogo:
            return Observable.just(Mutation.setLogo(true))
        case .errorOccered(let type):
            return Observable.just(Mutation.setAlert(message: type.desc))
        case .getUser:
            return
                self.getProfile()
                    .map { result in
                    if let user = result.value {
                        return Mutation.setUser(user: user)
                    } else {
                        return Mutation.setError(
                            error: .NETWORK(failure: result.failed,
                                            error: result.error)
                        )
                    }
                }
        case .route(let view):
            return Observable.just(Mutation.setDestination(to: view))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setLoading(let loading):
            newState.isLoading = loading
        case .setAlert(let message):
            newState.message = message
        case .setUser(user: let user):
            newState.user = user
        case .setError(let error):
            switch error {
            case .UNKNOWN:
                newState.error = ReactorError.UNKNOWN
            case .NETWORK(let failure, let error):
                newState.failure = failure
                newState.error = error
            }
        case .setLogo(let logoshown):
            newState.logoShown = logoshown
        case .setDestination(to: let view):
            newState.destination = view
        }
        
        return newState
    }
}
