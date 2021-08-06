//
//  BottomMenuReactor.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/06.
//

import Foundation
import ReactorKit
import RxCocoa

class BottomMenuReactor: Reactor, APIService {
    var session: NetworkService = NetworkService()
    var initialState: State = State()
    
    private func getToggledBottomMenuState(currentState: BottomMenuState) -> BottomMenuState {
        return currentState == .CLOSED ? .EXPANDED : .CLOSED
    }
    
    enum Action {
//        case toggleBottomMenu
        case getTodos
//        case showIndicator
//        case hideIndicator
//        case showError(error: ReactorError)
    }
    
    enum Mutation {
        case setTodos(todos: [Todo])
        case setIndicator(isOn: Bool)
        case setError(error: ReactorError)
    }
    
    struct State {
        var todos: [Todo] = []
        var isLoading: Bool = false
        var error: ReactorError?
    }
    
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        let refreshTodos = BottomMenuManager.shared.eventRelay
            .asObservable()
            .distinctUntilChanged()
            .filter { $0 == .openMenu }
            .flatMapLatest { event -> Observable<Action> in
                return .just(Action.getTodos)
            }
            .observe(on: MainScheduler.asyncInstance)

        return Observable.merge(action, refreshTodos)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        var getTodos: Observable<Mutation> {
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
        }
        
        switch action {
        case .getTodos:
            return getTodos
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State()
        switch mutation {
        case .setError(error: let error):
            newState.error = error
        case .setIndicator(isOn: let isOn):
            newState.isLoading = isOn
        case .setTodos(todos: let todos):
            newState.todos = todos
        }
        return newState
    }
    
}
