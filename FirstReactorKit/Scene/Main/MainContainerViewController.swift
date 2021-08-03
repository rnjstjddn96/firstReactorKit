//
//  MainContainerViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/03.
//

import UIKit
import RxCocoa
import SnapKit
import ReactorKit

class MainContainerViewController: UIViewController {
    
    var bottomMenuViewBottomOffset: Constraint?
    var bottomMenuState: BottomMenuState = .CLOSED
    
    let disposeBag = DisposeBag()
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
        self.addChild(mainContentViewController)
        self.view.addSubview(mainContentViewController.view)
        self.mainContentViewController.willMove(toParent: self)
        self.mainContentViewController.didMove(toParent: self)
        
        self.addChild(bottomMenuViewController)
        self.view.addSubview(bottomMenuViewController.view)
        self.bottomMenuViewController.willMove(toParent: self)
        bottomMenuViewController.didMove(toParent: self)
        
        let tapGesture = UITapGestureRecognizer()
        self.bottomMenuViewController.view.addGestureRecognizer(tapGesture)
        tapGesture.rx.event
            .bind(onNext: { [weak self] tap in
                guard let self = self else { return }
                self.mutateBottomMenuOffset()
            })
            .disposed(by: disposeBag)
        
        setBottomMenuViewConstraints()
    }
    
    private func setBottomMenuViewConstraints() {
        self.bottomMenuViewController.view.snp.makeConstraints { [weak self] create in
            guard let self = self else { return }
            create.left.right.equalToSuperview()
            self.bottomMenuViewBottomOffset = create.top.equalTo(self.view.snp.bottom)
                .offset(-self.bottomMenuState.amount).constraint
            create.height.equalToSuperview().offset(-100)
            
            bottomMenuViewBottomOffset?.activate()
        }
    }
    
    private func toggleBottomMenuState() {
        switch self.bottomMenuState {
        case .CLOSED:
            self.bottomMenuState = .EXPANDED
        case .EXPANDED:
            self.bottomMenuState = .CLOSED
        }
    }
    
    private func mutateBottomMenuOffset() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.toggleBottomMenuState()
            self.bottomMenuViewBottomOffset?
                .update(offset: -self.bottomMenuState.amount)
            self.view.layoutIfNeeded()
        }
    }
}
