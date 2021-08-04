//
//  MainReactor.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/04.
//

import Foundation
import ReactorKit

class MainReactor: Reactor {
    var initialState: State = State()
    
    enum Action {
        case toggleBottomMenu
    }
    
    enum Mutation {
        case setBottomMenuState(_ state: BottomMenuState)
    }
    
    struct State {
        var bottomMenuState: BottomMenuState = .CLOSED
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
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State()
        switch mutation {
        case .setBottomMenuState(let state):
            newState.bottomMenuState = state
        }
        return newState
    }
}
