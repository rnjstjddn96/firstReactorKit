//
//  WalletReactor.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/06.
//

import Foundation
import ReactorKit
import RxCocoa

class WalletReactor: Reactor {
    var initialState: State = State()
    
    enum Action {
        case loadMenu(menus: [TabBarInterface])
//        case showIndicator
//        case hideIndicator
//        case showError(error: ReactorError)
    }
    
    enum Mutation {
        case setMenu(menus: [TabBarInterface])
        case setIndicator(isOn: Bool)
        case setError(error: ReactorError)
    }
    
    struct State {
        var menus: [TabBarInterface] = []
        var isLoading: Bool = false
        var error: ReactorError?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadMenu(menus: let menus):
            return Observable.just(.setMenu(menus: menus))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState: State = state
        switch mutation {
        case .setError(error: let error):
            newState.error = error
        case .setIndicator(isOn: let isOn):
            newState.isLoading = isOn
        case .setMenu(menus: let menus):
            newState.menus = menus
        }
        return newState
    }
    
}
