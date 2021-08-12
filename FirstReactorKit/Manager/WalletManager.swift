//
//  BottomMenuManager.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/07.
//

import Foundation
import RxSwift
import RxCocoa

protocol BottomMenuServiceProtocol {
    var eventRelay: PublishRelay<WalletEvent> { get }
    var currentState: BehaviorRelay<WalletState> { get }
    var selectedMenu: BehaviorRelay<WalletMenu> { get }
    func updateState(event: WalletEvent) -> Observable<WalletState>
}

class WalletManager: BottomMenuServiceProtocol {
    static let shared = WalletManager()
    
    //Wallet 이벤트 시퀀스
    var eventRelay = PublishRelay<WalletEvent>()
    //Wallet state 시퀀스
    var currentState = BehaviorRelay<WalletState>(value: .CLOSED)
    
    //Wallet TabState
    var selectedMenu = BehaviorRelay<WalletMenu>(value: .PAYMENT)
    
    func updateState(event: WalletEvent) -> Observable<WalletState> {
        eventRelay.accept(event)
        currentState.accept(event.state)
        return .just(event.state)
    }
}

enum WalletState {
    case EXPANDED, CLOSED
    
    var amount: CGFloat {
        switch self {
        case .CLOSED:
            return WalletIndicator.INDICATOR_HEIGHT
        case .EXPANDED:
            return SIZE.height - safeAreas[.top]!
        }
    }
}

enum WalletEvent {
    case openMenu
    case closeMenu
    
    var state: WalletState {
        switch self {
        case .openMenu:
            return .EXPANDED
        case .closeMenu:
            return .CLOSED
        }
    }
}


