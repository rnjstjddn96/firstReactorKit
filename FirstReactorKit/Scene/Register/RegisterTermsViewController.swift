//
//  RegisterTermsViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/14.
//

import Foundation
import UIKit
import ReactorKit

class RegisterTermsViewController: BaseViewController<RegisterTermsViewReactor> {
    lazy var navigationBar = NavigationBar(frame: .zero,
                                           title: reactor?.service.currentPhase.value.title,
                                           leftType: nil,
                                           rightType: .close)
    override func viewDidLoad() {
        self.view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { create in
            create.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            create.left.right.equalToSuperview()
            create.height.equalTo(80)
        }
        self.view.backgroundColor = .yellow
    }
}

extension RegisterTermsViewController: View {
    func bind(reactor: Reactor) {
        self.navigationBar.rightButton?.rx
            .tapGesture()
            .when(.recognized)
            .map { _ in
                Reactor.Action.headToUserAuth
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

class RegisterTermsViewReactor: Reactor {
    var initialState: State = State()
    var service: RegisterServiceProtocol
    
    init(service: RegisterServiceProtocol) {
        self.service = service
    }
    
    enum Action {
//        case getTerms
        case headToUserAuth
    }
    
    enum Mutation {
//        case setTerms(terms: [Term])
        case updateAgreedTerms(terms: [String])
    }
    
    struct State {
        var terms: [Term] = []
        var agreedTerms: [String] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .headToUserAuth:
            return Observable.just(Mutation.updateAgreedTerms(terms: currentState.agreedTerms))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateAgreedTerms(let agreedTerms):
            service.registerUserDto.setAgreedTerms(terms: agreedTerms)
            service.makeEvent(.updatePhase(direction: .next))
        }
        return newState
    }
}
