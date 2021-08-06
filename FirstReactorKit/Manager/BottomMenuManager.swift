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
    var eventRelay: PublishRelay<BottomMenuEvent> { get }
    var currentState: BehaviorRelay<BottomMenuState> { get }
    func updateState(event: BottomMenuEvent) -> Observable<BottomMenuState>
}

class BottomMenuManager: BottomMenuServiceProtocol {
    static let shared = BottomMenuManager()
    
    var eventRelay = PublishRelay<BottomMenuEvent>()
    var currentState = BehaviorRelay<BottomMenuState>(value: .CLOSED)
    
    func updateState(event: BottomMenuEvent) -> Observable<BottomMenuState> {
        eventRelay.accept(event)
        currentState.accept(event.menuState)
        return .just(event.menuState)
    }
}

enum BottomMenuState {
    case EXPANDED, CLOSED
    
    var amount: CGFloat {
        switch self {
        case .CLOSED:
            return BottomMenuIndicator.INDICATOR_HEIGHT
        case .EXPANDED:
            return UIScreen.main.bounds.size.height - 100
        }
    }
}

enum BottomMenuEvent {
    case openMenu
    case closeMenu
    
    var menuState: BottomMenuState {
        switch self {
        case .openMenu:
            return .EXPANDED
        case .closeMenu:
            return .CLOSED
        }
    }
}


