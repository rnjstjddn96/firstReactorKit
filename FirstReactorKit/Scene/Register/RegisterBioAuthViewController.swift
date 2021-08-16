//
//  RegisterBioAuthViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/14.
//

import Foundation
import UIKit
import ReactorKit

class RegisterBioAuthViewController: BaseViewController<RegisterBioAuthViewReactor> {
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

extension RegisterBioAuthViewController: View {
    func bind(reactor: Reactor) {
        self.navigationBar.rightButton?.rx
            .tapGesture()
            .when(.recognized)
            .bind { _ in
                reactor.service.makeEvent(.updatePhase(direction: .next))
            }
            .disposed(by: disposeBag)
    }
}

class RegisterBioAuthViewReactor: Reactor {
    typealias Action = NoAction
    var initialState: State = State()
    var service: RegisterServiceProtocol
    
    init(service: RegisterServiceProtocol) {
        self.service = service
    }
    
    struct State {
        
    }
}



