//
//  HomeReactor.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/19.
//

import Foundation
import ReactorKit

class HomeReactor: Reactor {
    enum Action {
        case increase
        case decrease
        case route(to: UIViewController)
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
        case setDestinaion(view: UIViewController)
    }
    
    struct State {
        var value: Int = 0
        var isLoading: Bool = false
        var destination: UIViewController?
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
        }
        return newState
    }
}
