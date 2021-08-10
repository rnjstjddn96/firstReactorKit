//
//  MenuReactor.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/09.
//

import Foundation
import ReactorKit

class MenuRouteCellReactor: Reactor {
    typealias Action = NoAction
    let initialState: Menu
  
    init(state: Menu) {
        self.initialState = state
    }
}

class MenuSwitchCellRector: Reactor {
    let initialState: State
    
    init(menu: Menu) {
        self.initialState = State(menu: menu)
    }
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var menu: Menu?
    }
  
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        return newState
    }
    
}
