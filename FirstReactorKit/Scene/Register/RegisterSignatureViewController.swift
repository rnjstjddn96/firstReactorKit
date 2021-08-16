//
//  RegisterSignatureViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/14.
//

import Foundation
import UIKit
import ReactorKit

class RegisterSignatureViewController: BaseViewController<RegisterSignatureViewReactor> {
    let dummyToken =
        "kBol2fLUZUebdWbCfsPgHjFm37DRvXlqI+J0VvOjUJItnLsdva7bfjwoWsnPqKfozkR8MXoO3QUtzW4GNxbf4yjbrxqeJuCa5x0LPCSmLFPn4zFZk7T6zkjxZEMlkn8rRMcvwJqb/ilDpsKuiPSNJ29pjvY4pkd9gv6bC70+4kecXadjDBjau3myCcD8F/eUl8TYb96aatco8lpe/7RWpX/kmRdfY8DpClmmX+uGZDtQmAm/FmIrm1wFjaZnDCilxmOp/r15uMCutbR1WX8dS6iQDn/xrVcIyv5ePoAiZClVYSawliGQxC8WnMNYX3+/2TWMrVD+ykxoKvv4wAMeMQstLkkaE6aV/P3IPKetFGyvKcZX4ToX8TtSDSKu5W6Wqj9z5qEMUlfQQE31wrtfCgTLQOfk/jGQnj8QkcsAN8SGDwthfBt8WMvt9rM0n+bZcLb0X7DbgoRi2+BC6d7GvxmXBBS5G3A/uM40HSgLUIVJ7/72RjRG/bEzyy7C5Di5dA227T8ETx4VyKiXALzbdnc0vlqbTinYpm5ZGnjYAc2Sd4FpL0I7eyPhFkvqftkUrMFRLJiVs0ekvEMqIcOD8tLVBSK9wVK98mQeDo9eYrJAUInZclkTByvC9PokMNZNuP2LemEMi99t7YXg9LlvUYrNsnjfSJxTd0s4mDH10kU="
    
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

extension RegisterSignatureViewController: View {
    func bind(reactor: Reactor) {
        self.navigationBar.rightButton?.rx
            .tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                reactor.service.makeEvent(.updatePhase(direction: .next))
//                prefs.setValue(self.dummyToken, forKey: PrefsEnum.X_AUTH_TOKEN.rawValue)
            }
            .disposed(by: disposeBag)
    }
}

class RegisterSignatureViewReactor: Reactor {
    typealias Action = NoAction
    var initialState: State = State()
    var service: RegisterServiceProtocol
    
    init(service: RegisterServiceProtocol) {
        self.service = service
    }
    
    struct State {
        
    }
}


