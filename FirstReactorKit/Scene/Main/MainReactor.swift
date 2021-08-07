//
//  MainReactor.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/04.
//

import Foundation
import ReactorKit

class MainReactor: Reactor, APIService {
    var initialState: State = State()
    var session: NetworkService = NetworkService()
    
    enum Action {
        case showIndicator
        case hideIndicator
        case showError(error: ReactorError)
    }
    
    enum Mutation {
        case setIndicator(isOn: Bool)
        case setError(error: ReactorError)
    }
    
    struct State {
        var todos: [Todo] = []
        var isLoading: Bool = false
        var error: ReactorError?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .showIndicator:
            return Observable.just(Mutation.setIndicator(isOn: true))
        case .hideIndicator:
            return Observable.just(Mutation.setIndicator(isOn: false))
        case .showError(let error):
            return Observable.just(Mutation.setError(error: error))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State()
        switch mutation {
        case .setIndicator(isOn: let isOn):
            newState.isLoading = isOn
        case .setError(error: let error):
            newState.error = error
        }
        return newState
    }
}
