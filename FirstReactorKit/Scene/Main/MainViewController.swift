//
//  MainViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/03.
//

import UIKit
import RxCocoa
import SnapKit
import ReactorKit
import RxGesture

class MainViewController: BaseViewController<MainReactor> {
    var walletBottomOffset: Constraint?
    
    let homeViewController = HomeViewController()
    let walletViewController = WalletViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setChilds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setChilds() {
        homeViewController.reactor = HomeReactor()
        self.addChild(homeViewController)
        self.view.addSubview(homeViewController.view)
        self.homeViewController.willMove(toParent: self)
        self.homeViewController.didMove(toParent: self)
        
        walletViewController.reactor = WalletReactor()
        self.addChild(walletViewController)
        self.view.addSubview(walletViewController.view)
        self.walletViewController.willMove(toParent: self)
        walletViewController.didMove(toParent: self)
        
        setBottomMenuViewConstraints()
    }
    
    private func setBottomMenuViewConstraints() {
        self.walletViewController.view.snp.makeConstraints { [weak self] create in
            guard let self = self else { return }
            create.left.right.equalToSuperview()
            self.walletBottomOffset = create.top.equalTo(self.view.snp.bottom)
                .offset(-(WalletManager.shared.currentState.value.amount))
                .constraint
            create.height.equalToSuperview()
                .offset(-safeAreas[.top]!)
            
            walletBottomOffset?.activate()
        }
    }
    
    private func mutateBottomMenuOffset(offset: CGFloat) {
        self.view.animateWithSpring(duration: 0.5,
                                    damping: 0.9,
                                    initialVelocity: 5) { [weak self] in
            guard let self = self else { return }
            self.walletBottomOffset?
                .update(offset: -offset)
        }
    }
    
    private func displayReactorError(error: ReactorError,
                                     action: (() -> Void)? = nil) {
        AlertUtils.displayBasicAlert(controller: self,
                                     title: "에러가 발생했습니다.",
                                     message: error.desc,
                                     showCancelButton: false,
                                     okButtonTitle: "확인",
                                     cancelButtonTitle: nil,
                                     okButtonCallback: action,
                                     cancelButtonCallback: nil)
    }
}

extension MainViewController: View {
    func bind(reactor: Reactor) {
        reactor.state
            .map { $0.error }
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] error in
                guard let self = self else { return }
                self.displayReactorError(error: error!)
            })
            .disposed(by: disposeBag)
        
        WalletManager.shared
            .eventRelay
            .asObservable()
            .bind(onNext: { [weak self] event in
                guard let self = self else { return }
                self.mutateBottomMenuOffset(offset: event.state.amount)
//                switch event {
//                case .openMenu:
//                    break;
//                case .closeMenu:
//                    break;
//                }
            })
            .disposed(by: disposeBag)
    }
}
