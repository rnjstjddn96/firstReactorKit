//
//  RegisterContainerViewReactor.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/15.
//

import Foundation
import ReactorKit
import UIKit
import RxCocoa

class RegisterConatainerReactor: Reactor {
    var initialState: State = State()
    var service: RegisterServiceProtocol
    
    init(registerService: RegisterServiceProtocol) {
        self.service = registerService
    }
    
    enum Action {
        case updateDirection(direction: RegisterEvent.PhaseDireaction)
        case dismiss
        case register
    }
    
    enum Mutation {
        case initRegisterUserDto
        case requestRegistration
        case setDirection(direction: RegisterEvent.PhaseDireaction)
        case setCurrentPhase(phase: RegisterPhase?)
    }
    
    struct State {
        var phaseDirection: RegisterEvent.PhaseDireaction = .next
        var destination: UIViewController?
        var registerUserDto = RegisterUserDto()
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let currentPhaseEvent = service.currentPhase
            .map { Mutation.setCurrentPhase(phase: $0) }
        return Observable.merge(mutation, currentPhaseEvent)
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        let serviceEvent = service.eventRelay
            .map { event -> Action in
                switch event {
                case .dismiss:
                    return Action.dismiss
                case .updatePhase(let direction):
                    return Action.updateDirection(direction: direction)
                case .register:
                    return Action.register
                }
            }
        return Observable.merge(action, serviceEvent)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateDirection(let direction):
            return Observable.just(.setDirection(direction: direction))
        case .dismiss:
            return
                Observable.concat([
                    Observable.just(.initRegisterUserDto),
                    Observable.just(.setCurrentPhase(phase: nil))
                ])
        case .register:
            return Observable.concat([
                //MARK: state의 dto를 암호화 후 appuser 생성 api 호출
                Observable.just(.requestRegistration)
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setDirection(let direction):
            newState.phaseDirection = direction
            
        case .setCurrentPhase(let phase):
            switch phase {
            case .term:
                let destination = RegisterTermsViewController()
                destination.reactor = reactorForTermsView()
                newState.destination = destination
            case .user_auth:
                let destination = RegisterUserAuthViewController()
                destination.reactor = reactorForUserAuthView()
                newState.destination = destination
            case .pincode:
                let destination = RegisterPincodeViewController()
                destination.reactor = reactorForPincodeView()
                newState.destination = destination
            case .bio:
                let destination = RegisterBioAuthViewController()
                destination.reactor = reactorForBioAuthView()
                newState.destination = destination
            case .signature:
                let destination = RegisterSignatureViewController()
                destination.reactor = reactorForSignatureView()
                newState.destination = destination
            case .none:
                newState.destination = nil
            }
        case .initRegisterUserDto:
            service.registerUserDto.initUserInfo()
        case .requestRegistration:
            return newState
        }
        return newState
    }
}

extension RegisterConatainerReactor {
    func reactorForTermsView() -> RegisterTermsViewReactor {
        return RegisterTermsViewReactor(service: self.service)
    }
    
    func reactorForUserAuthView() -> RegisterUserAuthReactor {
        return RegisterUserAuthReactor(service: self.service)
    }
    
    func reactorForPincodeView() -> RegisterPincodeReactor {
        return RegisterPincodeReactor(service: self.service)
    }
    
    func reactorForBioAuthView() -> RegisterBioAuthViewReactor {
        return RegisterBioAuthViewReactor(service: self.service)
    }
    
    func reactorForSignatureView() -> RegisterSignatureViewReactor {
        return RegisterSignatureViewReactor(service: self.service)
    }
}
