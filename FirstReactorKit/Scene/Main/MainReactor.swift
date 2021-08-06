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
        case toggleBottomMenu
        case showIndicator
        case hideIndicator
        case showError(error: ReactorError)
        
        //MARK: Data
        case getTodos
    }
    
    enum Mutation {
        case setBottomMenuState(_ state: BottomMenuState)
        case setTodos(todos: [Todo])
        case setIndicator(isOn: Bool)
        case setError(error: ReactorError)
    }
    
    struct State {
        var bottomMenuState: BottomMenuState = .CLOSED
        var todos: [Todo] = []
        var isLoading: Bool = false
        var error: ReactorError?
    }
    
    private func getToggledBottomMenuState(currentState: BottomMenuState) -> BottomMenuState {
        return currentState == .CLOSED ? .EXPANDED : .CLOSED
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .toggleBottomMenu:
            return Observable.just(
                Mutation.setBottomMenuState(
                    getToggledBottomMenuState(currentState: currentState.bottomMenuState)
                )
            )
        case .getTodos:
            return Observable.concat([
                Observable.just(Mutation.setIndicator(isOn: true)),
                self.getTodos()
                    .map { result in
                        if let todos = result.value {
                            return Mutation.setTodos(todos: todos)
                        } else {
                            return Mutation.setError(
                                error: .NETWORK(failure: result.failed,
                                                error: result.error)
                            )
                        }
                    },
                Observable.just(Mutation.setIndicator(isOn: false))
            ])
            
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
        case .setBottomMenuState(let state):
            newState.bottomMenuState = state
        case .setTodos(todos: let todos):
            newState.todos = todos
        case .setIndicator(isOn: let isOn):
            newState.isLoading = isOn
        case .setError(error: let error):
            newState.error = error
        }
        return newState
    }
}
