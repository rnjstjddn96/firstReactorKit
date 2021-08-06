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

class MainViewController: UIViewController {
    var bottomMenuViewBottomOffset: Constraint?
    
    var disposeBag = DisposeBag()
    let homeViewController: HomeViewController = {
        let vc = HomeViewController()
        let homeReactor = HomeReactor()
        vc.reactor = homeReactor
        return vc
    }()
    
    let bottomMenuViewController = BottomMenuViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setChilds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setChilds() {
        self.addChild(homeViewController)
        self.view.addSubview(homeViewController.view)
        self.homeViewController.willMove(toParent: self)
        self.homeViewController.didMove(toParent: self)
        
        let bottomMenuReactor = self.reactor?.reactorForBottomMenu()
        bottomMenuViewController.reactor = bottomMenuReactor
        self.addChild(bottomMenuViewController)
        self.view.addSubview(bottomMenuViewController.view)
        self.bottomMenuViewController.willMove(toParent: self)
        bottomMenuViewController.didMove(toParent: self)
        
        setBottomMenuViewConstraints()
    }
    
    private func setBottomMenuViewConstraints() {
        self.bottomMenuViewController.view.snp.makeConstraints { [weak self] create in
            guard let self = self else { return }
            create.left.right.equalToSuperview()
            self.bottomMenuViewBottomOffset = create.top.equalTo(self.view.snp.bottom)
                .offset(-(bottomMenuViewController.reactor?.currentState.menuState.amount ?? 0)).constraint
            create.height.equalToSuperview()
                .offset(bottomMenuViewController.reactor?.currentState.menuState.amount ?? 0)
            
            bottomMenuViewBottomOffset?.activate()
        }
    }
    
    private func mutateBottomMenuOffset(offset: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 5) { [weak self] in
            guard let self = self else { return }
            self.bottomMenuViewBottomOffset?
                .update(offset: -offset)
            self.view.layoutIfNeeded()
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
    typealias Reactor = MainReactor
    
    func bind(reactor: Reactor) {
        reactor.state
            .map { $0.error }
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] error in
                guard let self = self else { return }
                self.displayReactorError(error: error!)
            })
            .disposed(by: disposeBag)
        
        reactor.bottomMenuService
            .eventRelay
            .asObservable()
            .bind { [weak self] event in
                guard let self = self else { return }
                self.mutateBottomMenuOffset(offset: event.menuState.amount)
                switch event {
                case .openMenu:
                    break;
                case .closeMenu:
                    break;
                }
            }
            .disposed(by: disposeBag)
    }
}
