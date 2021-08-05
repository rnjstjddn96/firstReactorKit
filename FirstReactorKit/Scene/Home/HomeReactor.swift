//
//  HomeReactor.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/19.
//

import Foundation
import ReactorKit

class HomeReactor: Reactor, APIService {
    var session: NetworkService = NetworkService()
    
    enum Action {
        case increase
        case decrease
        case route(to: UIViewController)
        case getToken(param: [String: Any])
        case getAnimal
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
        case setDestinaion(view: UIViewController)
        case setToken(token: Token)
        case setError(error: SplashError)
        case setAnimal(allAnimal: AllAnimal)
    }
    
    struct State {
        var value: Int = 0
        var isLoading: Bool = false
        var destination: UIViewController?
        var token: Token?
        var failure: APIFailure?
        var error: Error?
        var allAnimal: AllAnimal?
    }
    
    let initialState: State
    
    init() {
        self.initialState = .init()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.increaseValue)
                    .delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false)),
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue)
                    .delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false)),
            ])
        case .route(to: let view):
            return Observable.create { observer in
                observer.on(.next(Mutation.setDestinaion(view: view)))
                observer.onCompleted()
                return Disposables.create()
            }
        case .getToken(param: let param):
            return Observable.concat([
                     self.getToken(param: param)
                         .map { result in
                         if let data = result.value {
                             return Mutation.setToken(token: data)
                         } else {
                             return Mutation.setError(
                                 error: .NETWORK(failure: result.failed,
                                                 error: result.error)
                             )
                         }
                     }
                 ])
        case .getAnimal:
            return Observable.concat([
                     self.getAnimal()
                        .debug("getAnimal")
                         .map { result in
                         if let data = result.value {
                             return Mutation.setAnimal(allAnimal: data)
                         } else {
                             return Mutation.setError(
                                 error: .NETWORK(failure: result.failed,
                                                 error: result.error)
                             )
                         }
                     }
                 ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let loading):
            newState.isLoading = loading
        case .setDestinaion(view: let view):
            newState.destination = view
        case .setToken(token: let token):
            newState.token = token
        case .setError(let error):
            switch error {
            case .UNKNOWN:
                newState.error = SplashError.UNKNOWN
            case .NETWORK(let failure, let error):
                newState.failure = failure
                newState.error = error
            }
        case .setAnimal(allAnimal: let dogAnimal):
            newState.allAnimal = dogAnimal
        }
        return newState
    }
}
