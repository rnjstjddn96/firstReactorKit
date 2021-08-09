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
    typealias Action = NoAction
    let initialState: Menu
  
    init(state: Menu) {
        self.initialState = state
    }
}
