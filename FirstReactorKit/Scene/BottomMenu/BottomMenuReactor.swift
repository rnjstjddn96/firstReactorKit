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
    
    let service: BottomMenuServiceProtocol
    
    init(service: BottomMenuServiceProtocol) {
        self.service = service
    }
    
    
    private func getToggledBottomMenuState(currentState: BottomMenuState) -> BottomMenuState {
        return currentState == .CLOSED ? .EXPANDED : .CLOSED
    }
    
    enum Action {
        case toggleBottomMenu
        case getTodos
//        case showIndicator
//        case hideIndicator
//        case showError(error: ReactorError)
    }
    
    enum Mutation {
        case setMenuState(state: BottomMenuState)
        case setTodos(todos: [Todo])
        case setIndicator(isOn: Bool)
        case setError(error: ReactorError)
    }
    
    struct State {
        var menuState: BottomMenuState = .CLOSED
        var todos: [Todo] = []
        var isLoading: Bool = false
        var error: ReactorError?
    }
    
    
//    func transform(action: Observable<Action>) -> Observable<Action> {
//        let refreshTodos = service.eventRelay
//            .asObservable()
//            .distinctUntilChanged()
//            .filter { $0.menuState == .EXPANDED }
//            .flatMap { event -> Observable<Action> in
//                return .just(Action.getTodos)
//            }
//        return Observable.merge(action, refreshTodos)
//    }
    
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
        
        let currentMenuState = currentState.menuState
        switch action {
        case .toggleBottomMenu:
            switch currentMenuState {
            case .CLOSED:
                return
                    service.updateState(event: .openMenu)
                    .map { .setMenuState(state: $0) }
            case .EXPANDED:
                return
                    service.updateState(event: .closeMenu)
                    .map { .setMenuState(state: $0) }
            }
        case .getTodos:
            return getTodos
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State()
        switch mutation {
        case .setMenuState(state: let state):
            newState.menuState = state
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
