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
    var bottomMenutapGesture = UITapGestureRecognizer()
    
    var disposeBag = DisposeBag()
    let mainContentViewController: HomeViewController = {
        let vc = HomeViewController()
        let homeReactor = HomeReactor()
        vc.reactor = homeReactor
        return vc
    }()
    
    let bottomMenuViewController = BottomMenuViewController()
//    let bottomMenuReactor = BottomMenuReactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setChilds()
        self.setGestures()
    }
    
    private func setChilds() {
        self.addChild(mainContentViewController)
        self.view.addSubview(mainContentViewController.view)
        self.mainContentViewController.willMove(toParent: self)
        self.mainContentViewController.didMove(toParent: self)
        
        self.addChild(bottomMenuViewController)
        self.view.addSubview(bottomMenuViewController.view)
        self.bottomMenuViewController.willMove(toParent: self)
        bottomMenuViewController.didMove(toParent: self)
        
        setBottomMenuViewConstraints()
    }
    
    private func setGestures() {
        self.bottomMenuViewController.view.addGestureRecognizer(bottomMenutapGesture)
    }
    
    private func setBottomMenuViewConstraints() {
        self.bottomMenuViewController.view.snp.makeConstraints { [weak self] create in
            guard let self = self else { return }
            create.left.right.equalToSuperview()
            self.bottomMenuViewBottomOffset = create.top.equalTo(self.view.snp.bottom)
                .offset(-(self.reactor?.currentState.bottomMenuState.amount ?? 0)).constraint
            create.height.equalToSuperview()
                .offset(reactor?.currentState.bottomMenuState.amount ?? 0)
            
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
}

extension MainViewController: View {
    typealias Reactor = MainReactor
    
    func bind(reactor: Reactor) {
        
        //Tap Gesture tap event를 bind
        bottomMenutapGesture.rx.event
            .map { _ in
                Reactor.Action.toggleBottomMenu
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        //reactor의 offset 이벤트 처리
        reactor.state
            .skip(1)
            .map { $0.bottomMenuState.amount }
            .bind { [weak self] offset in
                guard let self = self else { return }
                self.mutateBottomMenuOffset(offset: offset)
            }
            .disposed(by: disposeBag)
    }
}
