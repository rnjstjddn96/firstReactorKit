//
//  BottomMenuService.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/06.
//

import Foundation
import RxSwift
import RxCocoa

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

protocol BottomMenuServiceProtocol {
    var eventRelay: PublishRelay<BottomMenuEvent> { get }
    func updateState(event: BottomMenuEvent) -> Observable<BottomMenuState>
}

class BottomMenuService: BottomMenuServiceProtocol {
    var eventRelay = PublishRelay<BottomMenuEvent>()
    
    func updateState(event: BottomMenuEvent) -> Observable<BottomMenuState> {
        eventRelay.accept(event)
        return .just(event.menuState)
    }
}
