//
//  CardCellReactor.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/14.
//

import Foundation
import ReactorKit

class CardCellReactor: Reactor {
    var initialState: State

    init(account: CardAccountInfo) {
        self.initialState = State(account: account)
    }
    
    typealias Action = NoAction

    struct State {
        var account: CardAccountInfo
        var isMainPayment: Bool = false
        var isSelected: Bool = false
    }

}
